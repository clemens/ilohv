require_dependency 'ancestry'

module Ilohv
  class Node < ActiveRecord::Base
    has_ancestry

    validates :name, presence: true
    validate :require_unique_path

    default_scope -> { order("name ASC") }

    before_validation :calculate_full_path

    def slug
      # TODO use stringex or something
      name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') if name.present?
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
