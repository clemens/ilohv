require 'spec_helper'

describe Ilohv::File do
  subject { build(:file) }

  it_behaves_like "a node"

  describe "validations" do
    let(:file) { build(:file) }

    it "requires a file" do
      file = build(:file, file: nil)

      expect(file).to_not be_valid
      expect(file.errors[:file].size).to eq 1
    end

    describe "file token" do
      it "requires a file token" do
        allow(SecureRandom).to receive(:uuid) { nil }

        expect(file).to_not be_valid
        expect(file.errors[:file_token].size).to eq 1
      end

      it "requires a file token" do
        existing_file = create(:file)

        allow(SecureRandom).to receive(:uuid) { existing_file.file_token }

        expect(file).to_not be_valid
        expect(file.errors[:file_token].size).to eq 1
      end
    end
  end

  describe "callbacks" do
    let(:file) { build(:file) }

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

    describe "#calculate_name" do
      let(:attributes) { { extension: 'bar' } }
      let(:file) { build(:file, attributes).tap { |file| allow(file).to receive(:extract_meta_data) } } # prevent meta data from being extracted

      context "when the name is blank" do
        let(:attributes) { super().merge(name: '', original_filename: 'foo.bar') }

        it "uses the original_filename" do
          file.valid?

          expect(file.name).to eq 'foo.bar'
        end
      end
    end

    describe "#generate_file_token" do
      it "generates a random file token on create" do
        uuid = '2ef79f76-2163-4b45-b5ce-74b271d84f8c'
        allow(SecureRandom).to receive(:uuid) { uuid }

        file = build(:file)
        file.valid?

        expect(file.file_token).to eq uuid
      end

      it "doesn't change the file token on update" do
        file = create(:file)

        expect { file.save }.to_not change(file, :file_token)
      end
    end
  end
end
