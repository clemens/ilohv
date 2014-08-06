require 'bundler/setup'

require 'combustion'

Combustion.initialize!(:active_record) # :action_controller, :action_view, :sprockets

require 'rspec/rails'

Dir['spec/support/**/*.rb'].each { |f| require(File.expand_path(f)) }
