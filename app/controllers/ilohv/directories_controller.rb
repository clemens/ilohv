require_dependency 'ilohv/application_controller'

module Ilohv
  class DirectoriesController < ApplicationController
    before_action :set_directory, only: [:show, :edit, :update, :destroy]
    before_action :build_directory, only: [:new, :create]
    before_action :set_include_subdirectories, only: [:index, :show]

    def index
      @directories = Directory.roots
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      @directory.assign_attributes(directory_params)

      if @directory.save
        redirect_to_parent_or_index(@directory, notice: 'Directory was successfully created.')
      else
        render :new
      end
    end

    def update
      if @directory.update(directory_params)
        redirect_to_parent_or_index(@directory, notice: 'Directory was successfully updated.')
      else
        render :edit
      end
    end

    def destroy
      @directory.destroy
      redirect_to_parent_or_index(@directory, notice: 'Directory was successfully deleted.')
    end

    private

    def set_directory
      @directory = params[:id].present? ? Directory.find(params[:id]) : Directory.find_by_full_path(params[:full_path])
    end

    def build_directory
      scope = params[:parent_id].present? ? Directory.find(params[:parent_id]).directories : Directory
      @directory = scope.new(type: 'Ilohv::Directory')
    end

    def directory_params
      params[:directory] ||= {}
      params[:directory].permit(:name)
    end

    def set_include_subdirectories
      @include_subdirectories = params[:include_subdirectories]
    end
  end
end
