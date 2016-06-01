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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "Project Updated!"
      redirect_to @project
    else
      flash[:error] = "Failed to update project"
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    flash[:success] = "Successfully deleted"
    redirect_to root_url
  end
  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
