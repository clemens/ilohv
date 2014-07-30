module Ilohv
  class Directory < Node
    def directories
      children.where(type: 'Ilohv::Directory')
    end

    def files
      children.where(type: 'Ilohv::File')
    end
  end
end
