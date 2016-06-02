require "rails_helper"

RSpec.feature "deleting projects" do
  scenario "User deletes existing project" do
    project = FactoryGirl.create(:project, name: "A new project")
    visit "/"

    click_link "A new project"
    click_link "Delete"

    expect(page).to have_content("Successfully deleted")
    expect(page).to have_no_content("A new project")
  end
end
