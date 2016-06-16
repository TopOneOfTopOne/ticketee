require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  it "handles non-existent project gracefully" do
    get :show, id: "random-id"

    expect(response).to redirect_to(projects_url)
    message = "Nothing here"
    expect(flash[:alert]).to eq message
  end

  it "handles permission errors gracefully" do
    project = FactoryGirl.create :project

    allow(controller).to receive(:current_user)
    get :show, id: project

    expect(response).to redirect_to(root_url)
    message = "Permission denied"
    expect(flash[:alert]).to eq message
  end
end
