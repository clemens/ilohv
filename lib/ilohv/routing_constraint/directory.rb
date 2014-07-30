module Ilohv
  module RoutingConstraint
    class Directory
      def matches?(request)
        path = request.parameters['path'].dup
        request.env['action_dispatch.request.request_parameters']['full_path'] = path

        Ilohv::Directory.find_by_full_path(path)
      end
    end
  end
end
