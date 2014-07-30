require_dependency 'ancestry'

module Ilohv
  class Node < ActiveRecord::Base
    has_ancestry

    default_scope -> { order("name ASC") }

    before_validation :calculate_full_path

    def slug
      # TODO use stringex or something
      name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    private

    def calculate_full_path
      parent_path = parent ? "#{parent.full_path}/" : ''
      self.full_path = parent_path + slug
    end

  end
end
