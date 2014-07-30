json.partial! 'ilohv/nodes/node', node: directory

json.directories directory.directories, partial: 'directory', as: :directory if local_assigns[:include_directories]
json.files       directory.files, partial: 'ilohv/files/file', as: :file if local_assigns[:include_files]
