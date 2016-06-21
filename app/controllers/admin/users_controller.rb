class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user, only: [:show, :edit, :update, :archive]
  before_action :set_projects, only: [:show, :edit, :create, :new]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    @users = User.exclude_archived.order :email
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    build_roles_for(@user)
    if @user.save
      redirect_to admin_users_url, notice: "Successfully created user"
    else
      flash[:alert] = "Failed to create user"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    User.transaction do
      @user.roles.clear
      build_roles_for(@user)

      if @user.update(user_params)
        redirect_to admin_users_url, notice: "Successfully edited user"
      else
        flash.now[:alert] = "Failed to edit user"
        render "edit"
        raise ActiveRecord::Rollback
      end
    end
  end

  def archive
    if @user == current_user
      redirect_to admin_users_url, notice: "Cannot archive yourself, that is dangerous"
    else
      @user.archive
      redirect_to admin_users_url, notice: "Successfully archived user"
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :email, :admin)
    end

    def authenticate_admin
      authenticate_user!

      unless current_user.admin?
        redirect_to root_url, alert: "You must be admin to do that."
      end
    end

    def set_user
      @user = User.find(params[:id])
    rescue
      redirect_to root_url, alert: "No such user"
    end

    def set_projects
      @projects = Project.order :name
    end

    def build_roles_for(user)
      role_data = params.fetch :roles, []
      role_data.each do |project_id, role_name|
        if role_name.present?
          user.roles.build(project_id: project_id, role: role_name)
        end
      end
    end
end
