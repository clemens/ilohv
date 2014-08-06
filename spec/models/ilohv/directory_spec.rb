require 'spec_helper'

describe Ilohv::Directory do
  subject { build(:directory) }

  it_behaves_like "a node"

  describe "associations" do
    let!(:directory) { create(:directory) }
    let!(:subdirectory) { create(:directory, parent: directory) }
    let!(:file) { create(:file, parent: directory) }

    it "finds subdirectories" do
      expect(directory.directories).to match_array [subdirectory]
    end

    it "finds files" do
      expect(directory.files).to match_array [file]
    end
  end
end
