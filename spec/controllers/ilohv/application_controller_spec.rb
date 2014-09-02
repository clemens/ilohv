require 'spec_helper'

describe Ilohv::ApplicationController, type: :controller do
  context 'parent controller' do
    it 'checks if parent controller class is correct' do
      expect(subject.class.superclass.name).to eq Ilohv.parent_controller
    end
  end
end
