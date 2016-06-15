require 'rails_helper'
RSpec.feature "Users can view projects" do
  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project }

  before do
    login_as user
    assign_role!(user, :viewer, project)
  end

  scenario "with the project details" do
    visit "/"

    click_link project.name
    expect(current_url).to eq project_url(project)
  end

  scenario "unless they do no have permission" do
    FactoryGirl.create :project, name: "hidden"

    visit "/"
    expect(page).to_not have_content "hidden"
  end
end
