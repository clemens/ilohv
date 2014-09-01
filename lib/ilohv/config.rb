module Ilohv
  class Config
    mattr_accessor :parent_controller
    @@parent_controller = 'ApplicationController'
  end
end
