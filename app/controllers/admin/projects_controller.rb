class Admin::ProjectsController < ApplicationController
  before_action :set_project, only: :destroy
  before_action :authenticate_admin
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

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

  def authenticate_admin
    authenticate_user!

    unless current_user.admin?
      redirect_to root_url, alert: "You must be admin to do that."
    end
  end
end
