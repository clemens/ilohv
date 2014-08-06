$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ilohv/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ilohv"
  s.version     = Ilohv::VERSION
  s.authors     = ["Clemens Kofler"]
  s.email       = ["clemens@railway.at"]
  s.homepage    = "https://github.com/clemens/ilohv"
  s.summary     = "Rails-mountable File Manager"
  s.description = "Rails-mountable File Manager"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.required_ruby_version = ">= 1.9"

  s.add_dependency "rails", ">= 3.2.1"
  s.add_dependency "jbuilder"
  s.add_dependency "ancestry"
  s.add_dependency "carrierwave"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "combustion"
  s.add_development_dependency "factory_girl"
end
