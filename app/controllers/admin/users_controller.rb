class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order :email
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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

    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "Successfully edited user"
    else
      flash.now[:alert] = "Failed to edit user"
      render "edit"
    end
  end

  def destroy
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
end
