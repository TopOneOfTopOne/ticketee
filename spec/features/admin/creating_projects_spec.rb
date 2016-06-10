require 'rails_helper'
RSpec.feature "creating projects" do
  before do
    login_as(FactoryGirl.create :user, :admin)

    visit "/"
    click_link "New Project"
  end
  scenario "with valid input" do
    fill_in "Name", with: "This is my Name"
    fill_in "Description", with: "This is the description"
    click_button "Create Project"

    project = Project.find_by(name: "This is my Name")
    expect(page.current_url).to eq(project_url(project))
    title = "This is my Name - Project - Ticketee"
    expect(page).to have_title title
  end

  scenario "with no input" do
    click_button "Create Project"

    expect(page).to have_content "Failed to create project"
    expect(page).to have_content "can't be blank"
  end
end
