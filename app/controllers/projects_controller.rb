class ProjectsController < ApplicationController
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
    @project = Project.find(params[:id])
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
