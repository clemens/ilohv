module Ilohv
  class FileUploader < CarrierWave::Uploader::Base
    def filename
       "#{model.send(:"#{mounted_as}_token")}.#{file.extension}" if original_filename.present?
    end
  end
end
