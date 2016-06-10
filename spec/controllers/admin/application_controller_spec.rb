require 'rails_helper'
# We are stubbing the current_user method.
# Cannot use wardan's `login_as` method because controller tests do not go through middleware.
# We do not want to test the logging in feature that is why we are stubbing.
# Conversely stubbing is not available to feature tests.
#   because you do not have direct access to controller instances
#
# There is no authenticate_user method avaliable to tests so an error is thrown
# we solve this by stubbing it and returning `nil`
RSpec.describe Admin::ApplicationController, type: :controller do

  let(:user) { FactoryGirl.create :user }
  before do
    allow(controller).to receive(:current_user).and_return user
    allow(controller).to receive(:authenticate_user!)
  end

  context "not admin" do
    it "cannot visit admin page" do
      get :index

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be admin to do that."
    end
  end

end
