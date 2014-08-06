require 'spec_helper'

describe Ilohv::FileUploader do
  let(:file) { create(:file) }
  let(:uploader) { described_class.new(file, :file) }

  it "assigns the model's file token as file name" do
    file.file_token = 'foo-bar'
    uploader.store!(File.open('spec/fixtures/unit-test.jpg'))

    expect(uploader.filename).to eq 'foo-bar.jpg'
  end
end
