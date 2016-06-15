class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
     @projects = Project.all
  end

  def show
    authorize @project, :show?
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Project Updated!"
      redirect_to @project
    else
      flash[:error] = "Failed to update project"
      render "edit"
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def set_project
      begin
        @project = Project.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Nothing here"
        redirect_to projects_url
      end
    end
end
