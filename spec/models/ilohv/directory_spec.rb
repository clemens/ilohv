require 'spec_helper'

describe Ilohv::Directory do
  subject { described_class.new }

  it_behaves_like "a node"

  describe "associations" do
    let!(:directory) { described_class.create(name: 'Test Directory') }
    let!(:subdirectory) { described_class.create(name: 'Subdirectory', parent: directory) }
    let!(:file) { Ilohv::File.create(name: 'File', parent: directory) }

    it "finds subdirectories" do
      expect(directory.directories).to match_array [subdirectory]
    end

    it "finds files" do
      expect(directory.files).to match_array [file]
    end
  end
end
