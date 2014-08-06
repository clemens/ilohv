require_dependency 'ancestry'
require_dependency 'babosa'

module Ilohv
  class Node < ActiveRecord::Base
    has_ancestry

    validates :name, presence: true
    validate :require_unique_path

    default_scope -> { order("name ASC") }

    before_validation :calculate_full_path

    def slug
      return unless name.present?

      # reproducing babosa's #normalize! without cleaning non-word characters because we need the . in filenames
      slug = name.dup.to_identifier
      slug.transliterate!
      slug.clean!
      slug.downcase!
      slug.with_separators!

      slug
    end

    def other_with_same_path?
      scope = self.class.where(full_path: full_path)
      scope = scope.where.not(id: id) if persisted?
      scope.any?
    end

    private

    def calculate_full_path
      self.full_path = [parent_full_path, slug].compact.join('/')
    end

    def parent_full_path
      parent.try(:full_path)
    end

    def require_unique_path
      errors.add(:name, :taken) if other_with_same_path?
    end

  end
end
