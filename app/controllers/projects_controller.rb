class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
     @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project Created!"
    else
      flash.now[:error] = "Failed to create project"
      render "new"
    end
  end

  def show
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

  def destroy
    @project.destroy

    flash[:success] = "Successfully deleted"
    redirect_to root_url
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
