require 'bundler/setup'

require 'combustion'

Combustion.initialize!(:active_record, :action_controller) do # :action_controller, :action_view, :sprockets
  require 'jbuilder'
  require 'jbuilder/jbuilder_template'
  Ilohv::Engine.config.url_root = '/files'
end

require 'rspec/rails'

Dir['spec/support/**/*.rb'].each { |f| require(File.expand_path(f)) }

RSpec.configure do |config|
  require 'factory_girl'
  Dir['spec/factories/**/*.rb'].each { |f| require(File.expand_path(f)) }
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) { FactoryGirl.lint }
end
