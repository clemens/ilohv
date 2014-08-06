# ilohv

ilohv is a simple file manager, implemented as a mountable engine for Rails apps.

## Dat name, though?

```
ruby -e "puts 'ilohv'.chars.map { |c| (c.ord - 3).chr }.join"
```

## Usage

ilohv requires Rails version 3.2.1 or higher. This is due to the fact that it uses Rails' [ActiveRecord::Store](http://apidock.com/rails/ActiveRecord/Store) feature which was added in that version.

ilohv uses the Ruby 1.9+ hash syntax so Ruby 1.8 is explicitly not supported.

To use ilohv add it to your Gemfile, configure the URL root in an initializer and mount it in your application:

``` ruby
# Gemfile:
gem 'ilohv'

# config/initializers/ilohv.rb
Ilohv::Engine.config.url_root = '/admin/files'

# config/routes.rb
mount Ilohv::Engine, at: Ilohv::Engine.config.url_root
```

ilohv is then usable at the specified URL root, e.g. `http://localhost:3000/admin/files`.

## Additional configuration

ilohv uses CarrierWave underneath and the configuration is entirely up to you and your application.

There are no assumptions on how or where you want to store your files except for generating unique filenames. This is done to ensure that your application doesn't accidentally overwrite files with the same name if your storage settings don't ensure unique file paths. By default, UUIDs are generated when a file is being created (using `SecureRandom.uuid`). You can turn UUID-based filenames off or change it by just overriding the `Ilohv::FileUploader#filename` method:

``` ruby
# config/initializers/ilohv.rb
Ilohv::FileUploader.class_eval do
  def filename
    super # restore default behavior
  end
end

**In this case, it's up to your application to ensure that name clashes are prevented.**

All other configuration (e.g. where your files are stored, which file types are allowed...) is entirely up to your application.

ilohv will pick up your default CarrierWave configuration if you're already using CarrierWave in your application. Otherwise you can just add an initializer to configure CarrierWave (check the [Configuration section of the CarrierWave readme](https://github.com/carrierwaveuploader/carrierwave#configuring-carrierwave) for details).

You can also have a specific configuration for just the `Ilohv::FileUploader`:

``` ruby
# config/initializers/ilohv.rb
Ilohv::FileUploader.class_eval do
  storage :fog # put files on some cloud provider like S3 instead of a local directory

  def store_dir
    'ilohv_files' # put files in a subdirectory instead of right in the root
  end
end
```

Again, check the [CarrierWave readme](https://github.com/carrierwaveuploader/carrierwave#carrierwave) for details.

## Styling

ilohv sports a simple interface based on [Twitter Bootstrap 3](http://getbootstrap.com/) classes. If your application already uses Bootstrap, you should be good to go. If not, you have three options:

- Use Bootstrap 3 (duh!).
- Add CSS for the selectors being used.
- Override ilohv's views as you see fit by putting your own templates in app/views/ilohv.

## API

ilohv provides a simple API that exposes directories and their files as JSON. You can query the API like so:

  `curl http://localhost:3000/admin/files/path/to/directory.json`

Assuming `localhost:3000` is the server you're running ilohv on and ilohv is mounted at `/admin/files`, this returns the contents of the directory located in `path/to/directory`.

A simplistic API client could look like this:

``` ruby
require 'json'
require 'open-uri'

class Directory
  attr_reader :name, :full_path, :files

  def self.find_by_path(path)
    begin
      new(JSON.parse(open("http://localhost:3000/files/#{path}.json").read))
    rescue
    end
  end

  def initialize(attributes = {})
    @name, @full_path = attributes.values_at('name', 'full_path')
    @files = Array(attributes['files']).map { |file_attributes| OpenStruct.new(file_attributes) }
  end
end
```

Input validation, authentication/authorization and all that jazz should be done in your application(s) – ilohv just exposes directories, you're responsible for everything else.

## TODO

- use proper paths for new/create/edit/update/destroy routes (no IDs)

## Credits

© 2014 Clemens Kofler, licensed under the MIT License.

I've written this gem as part of a project for [The Mobility House](http://mobilityhouse.com/). Huge thanks to them for supporting Open Source by encouraging me to publish it.
