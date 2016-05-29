require 'rails_helper'
RSpec.feature "Users can create projects" do
  scenario "with valid input" do
    visit "/"

    click_link "New Project"

    fill_in "Name", with: "This is my Name"
    fill_in "Description", with: "This is the description"
    click_button "Create Project"
  end
end
