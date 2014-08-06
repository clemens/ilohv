module Ilohv
  class File < Node
    mount_uploader :file, FileUploader

    store :meta_data, accessors: [:content_type, :size, :original_filename, :extension]

    validates :file, presence: true

    before_validation :calculate_name, prepend: true
    before_validation :extract_meta_data, prepend: true, if: -> { file.present? && file_changed? }

    delegate :url, to: :file

    def slug
      # TODO use stringex or something
      name.downcase.strip.gsub(' ', '-').gsub(/[^\.\w-]/, '') if name.present?
    end

    private

    def calculate_name
      self.name = if name.present?
        extension.present? ? "#{name}.#{extension}" : name
      else
        original_filename
      end
    end

    def extract_meta_data
      self.content_type = file.file.content_type
      self.size = file.file.size
      self.original_filename = file.file.original_filename
      self.extension = ::File.extname(file.file.original_filename)[1..-1]
    end

  end
end
