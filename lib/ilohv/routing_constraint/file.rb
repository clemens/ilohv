module Ilohv
  module RoutingConstraint
    class File
      def matches?(request)
        path = request.parameters['path'].dup
        path += ".#{request.parameters['format']}" if request.parameters['format'].present?
        request.env['action_dispatch.request.request_parameters']['full_path'] = path

        Ilohv::File.find_by_full_path(path)
      end
    end
  end
end
