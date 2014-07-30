json.partial! 'ilohv/nodes/node', node: file

json.size         file.size
json.content_type file.content_type
json.extension    file.extension
json.url          ilohv_path(file.full_path)
json.direct_url   file.url
