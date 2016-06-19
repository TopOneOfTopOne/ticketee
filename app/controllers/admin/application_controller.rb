class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  
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
