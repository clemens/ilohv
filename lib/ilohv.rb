require 'ilohv/engine'

require 'carrierwave'

module Ilohv
  mattr_accessor :parent_controller
  @@parent_controller = 'ApplicationController'
end
