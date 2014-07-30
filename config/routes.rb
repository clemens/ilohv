Ilohv::Engine.routes.draw do
  root to: 'directories#index'

  require 'ilohv/routing_constraint/file'
  require 'ilohv/routing_constraint/directory'
  get '*path' => 'directories#show', constraints: Ilohv::RoutingConstraint::Directory.new
  get '*path' => 'files#show', constraints: Ilohv::RoutingConstraint::File.new

  resources :directories, except: :index
  resources :files, except: :index
end
