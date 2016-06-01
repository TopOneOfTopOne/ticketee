require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  it "handles non-existent project gracefully" do
    get :show, id: "random-id"

    expect(response).to redirect_to(projects_url)
    message = "Nothing here"
    expect(flash[:alert]).to eq message
  end

end
