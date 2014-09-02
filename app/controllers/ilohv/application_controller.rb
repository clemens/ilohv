module Ilohv
  class ApplicationController < Ilohv.parent_controller.constantize
    private

    def ilohv_path(path)
      "#{Ilohv::Engine.config.url_root}/#{path}"
    end
    helper_method :ilohv_path

    def redirect_to_parent_or_index(node, options)
      redirect_to node.parent ? ilohv_path(node.parent.full_path) : root_path, options
    end
  end
end
