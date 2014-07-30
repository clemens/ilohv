module Ilohv
  class File < Node
    mount_uploader :file, FileUploader

    store :meta_data, accessors: [:content_type, :size, :original_filename, :extension]

    before_validation :extract_meta_data, prepend: true

    delegate :url, to: :file

    def name
      "#{super}.#{extension}"
    end

    def slug
      # TODO use stringex or something
      name.downcase.strip.gsub(' ', '-').gsub(/[^\.\w-]/, '')
    end

    private

    def extract_meta_data
      if file.present? && file_changed?
        self.content_type = file.file.content_type
        self.size = file.file.size
        self.original_filename = file.file.original_filename
        self.extension = ::File.extname(file.file.original_filename)[1..-1]
      end
    end

  end
end
