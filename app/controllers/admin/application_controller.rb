class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin
  def index
  end

  private
    def authenticate_admin
      authenticate_user!

      unless current_user.admin?
        redirect_to root_url, alert: "You must be admin to do that."
      end
    end
end
