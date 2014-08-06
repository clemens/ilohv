require 'spec_helper'

describe Ilohv::DirectoriesController, type: :controller do
  render_views

  routes { Ilohv::Engine.routes }

  describe "GET to #index.json" do
    let(:directory_1) { double(:directory, name: 'Directory 1', full_path: 'directory-1', directories: [], files: []) }
    let(:directory_2) { double(:directory, name: 'Directory 2', full_path: 'directory-2', directories: [], files: []) }

    before(:each) do
      allow(Ilohv::Directory).to receive(:roots) { [directory_1, directory_2] }
    end

    it "lists all root directories" do
      get :index, format: :json
      json = JSON.parse(response.body)

      expect(json['directories']).to match [
        a_hash_including('name' => directory_1.name, 'full_path' => directory_1.full_path),
        a_hash_including('name' => directory_2.name, 'full_path' => directory_2.full_path),
      ]
    end
  end

  describe "GET to #show.json" do
    let(:directory) { double(:directory, name: 'A Directory', full_path: 'path/to/directory', directories: [], files: []) }

    before(:each) do
      allow(Ilohv::Directory).to receive(:find) { directory }
    end

    it "includes the directory name and path" do
      get :show, id: 1, format: :json
      json = JSON.parse(response.body)

      expect(json['name']).to eq directory.name
      expect(json['full_path']).to eq directory.full_path
    end

    it "includes the directory's immediate subdirectories" do
      subdirectory_1 = double(:directory, name: 'Subdirectory 1', full_path: directory.full_path + '/subdirectory-1')
      subdirectory_2 = double(:directory, name: 'Subdirectory 2', full_path: directory.full_path + '/subdirectory-2')
      allow(directory).to receive(:directories) { [subdirectory_1, subdirectory_2] }

      get :show, id: 1, format: :json
      json = JSON.parse(response.body)

      expect(json['directories']).to match [
        a_hash_including('name' => subdirectory_1.name, 'full_path' => subdirectory_1.full_path),
        a_hash_including('name' => subdirectory_2.name, 'full_path' => subdirectory_2.full_path),
      ]
    end

    it "includes the directory's immediate files" do
      file_1 = double(:file, name: 'File 1', full_path: directory.full_path + '/file-1.txt', size: 1234, content_type: 'text/plain', extension: 'txt', url: 'http://example.com/file-1.txt')
      file_2 = double(:file, name: 'File 2', full_path: directory.full_path + '/file-2.txt', size: 2345, content_type: 'text/plain', extension: 'txt', url: 'http://example.com/file-2.txt')
      allow(directory).to receive(:files) { [file_1, file_2] }
      allow(self).to receive(:ilohv_path).with(file_1.full_path) { "/files/#{file_1.full_path}"}
      allow(self).to receive(:ilohv_path).with(file_2.full_path) { "/files/#{file_2.full_path}"}

      get :show, id: 1, format: :json
      json = JSON.parse(response.body)

      expect(json['files']).to match [
        a_hash_including('name' => file_1.name, 'full_path' => file_1.full_path, 'size' => file_1.size, 'content_type' => file_1.content_type, 'extension' => file_1.extension, 'url' => "/files/#{file_1.full_path}", 'direct_url' => file_1.url),
        a_hash_including('name' => file_2.name, 'full_path' => file_2.full_path, 'size' => file_2.size, 'content_type' => file_2.content_type, 'extension' => file_2.extension, 'url' => "/files/#{file_2.full_path}", 'direct_url' => file_2.url),
      ]
    end
  end
end
