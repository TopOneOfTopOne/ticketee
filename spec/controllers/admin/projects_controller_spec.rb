require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do

  let(:user) { FactoryGirl.create :user }
  before do
    allow(controller).to receive(:current_user).and_return user
    allow(controller).to receive(:authenticate_user!)
  end

  context "not admin" do
    it "cannot create a project" do
      post :create

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be admin to do that."
    end

    it "cannot show new project page" do
      get :new

      expect(response).to redirect_to "/"
      expect(flash[:alert]).to eq "You must be admin to do that."
    end
  end
end
