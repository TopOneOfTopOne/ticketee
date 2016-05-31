require 'rails_helper'
RSpec.feature "Users can view projects" do
  scenario "with the project details" do
    project = FactoryGirl.create(:project, name: "A new project")
    visit "/"

    click_link "A new project"
    expect(current_url).to eq project_url(project)
  end
end
