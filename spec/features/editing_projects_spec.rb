require "rails_helper"

RSpec.feature "Users can edit projects" do
  before do
    FactoryGirl.create(:project, name: "A new project")

    visit "/"
    click_link "A new project"
    click_link "Edit this project"
  end
  scenario "with valid input" do
    fill_in "Name", with: "Changed name of project"
    click_button "Update Project"

    expect(page).to have_content "Project Updated!"
    expect(page).to have_content "Changed name of project"
  end

  scenario "with no input" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Failed to update project"
    expect(page).to have_content "Name can't be blank"
  end
end
