module Ilohv
  module RoutingConstraint
    class Directory
      def matches?(request)
        Ilohv::Directory.find_by_full_path(request.parameters['path'])
      end
    end
  end
end
