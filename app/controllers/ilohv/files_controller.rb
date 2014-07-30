require_dependency 'ilohv/application_controller'

module Ilohv
  class FilesController < ApplicationController
    before_action :set_file, only: [:show, :edit, :update, :destroy]
    before_action :build_file, only: [:new, :create]

    def show
      send_data @file.file.read, content_type: @file.content_type
    end

    def new
    end

    def edit
    end

    def create
      @file.assign_attributes(file_params)

      if @file.save
        redirect_to_parent_or_index(@file, notice: 'File was successfully created.')
      else
        render :new
      end
    end

    def update
      if @file.update(file_params)
        redirect_to_parent_or_index(@file, notice: 'File was successfully updated.')
      else
        render :edit
      end
    end

    def destroy
      @file.destroy
      redirect_to_parent_or_index(@file, notice: 'File was successfully deleted.')
    end

    private

    def set_file
      @file = params[:id] ? File.find(params[:id]) : File.find_by_full_path(params[:full_path])
    end

    def build_file
      scope = params[:parent_id] ? Directory.find(params[:parent_id]).files : File
      @file = scope.new(type: 'Ilohv::File')
    end

    def file_params
      params[:file] ||= {}
      params[:file].permit(:name, :file)
    end

  end
end
