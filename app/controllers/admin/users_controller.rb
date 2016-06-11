class Admin::UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:password, :email)
  end
end
