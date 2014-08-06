require 'spec_helper'

describe Ilohv::File do
  it_behaves_like "a node"

  describe "callbacks" do
    let(:file) { Ilohv::File.new }

    describe "#extract_meta_data" do
      it "extracts the file's meta data" do
        allow(file).to receive(:file) do
          uploaded_file = double(:uploaded_file, present?: true, content_type: 'type/foo', size: 1234, original_filename: 'type.foo')
          double(:carrierwave_file, file: uploaded_file)
        end
        allow(file).to receive(:file_changed?) { true }

        file.valid?

        expect(file.content_type).to eq 'type/foo'
        expect(file.size).to eq 1234
        expect(file.original_filename).to eq 'type.foo'
        expect(file.extension).to eq 'foo'
      end

      context "when the file wasn't changed" do
        it "doesn't extract the meta data" do
          allow(file).to receive(:file) { double(:file, present?: true) }
          allow(file).to receive(:file_changed?) { false }

          expect(file).to_not receive(:extract_meta_data)

          file.valid?
        end
      end

      context "when no file is present" do
        it "doesn't extract the meta data" do
          allow(file).to receive(:file) { nil }

          expect(file).to_not receive(:extract_meta_data)

          file.valid?
        end
      end
    end
  end
end
