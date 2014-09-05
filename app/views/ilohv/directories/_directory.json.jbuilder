json.partial! 'ilohv/nodes/node', node: directory

json.directories directory.directories, partial: 'directory', include_subdirectories: local_assigns[:include_subdirectories], as: :directory if local_assigns[:include_subdirectories] || local_assigns[:include_directories]
json.files       directory.files, partial: 'ilohv/files/file', include_subdirectories: local_assigns[:include_subdirectories], as: :file if local_assigns[:include_subdirectories] || local_assigns[:include_files]
