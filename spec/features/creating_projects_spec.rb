require 'rails_helper'
RSpec.feature "Users can create projects" do
  scenario "with valid input" do
    visit "/"

    click_link "New Project"

    fill_in "Name", with: "This is my Name"
    fill_in "Description", with: "This is the description"
    click_button "Create Project"

    project = Project.find_by(name: "This is my Name")
    expect(page.current_url).to eq(project_url(project))
    title = "This is my Name - Project - Ticketee"
    expect(page).to have_title title
  end
end
