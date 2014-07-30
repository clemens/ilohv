module Ilohv
  module RoutingConstraint
    class File
      def matches?(request)
        Ilohv::File.find_by_full_path(request.parameters['path'])
      end
    end
  end
end
