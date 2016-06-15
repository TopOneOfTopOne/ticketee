require "rails_helper"

RSpec.feature "Users can edit projects" do
  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create(:project, name: "A new project") }

  before do
    assign_role! user, :viewer, project
    login_as user

    visit "/"
    click_link "A new project"
    click_link "Edit"
  end

  scenario "with valid input" do
    fill_in "Name", with: "Changed name of project"
    click_button "Update Project"

    expect(page).to have_content "Project Updated!"
    expect(page).to have_content "Changed name of project"
  end

  scenario "but not with invalid input" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Failed to update project"
    expect(page).to have_content "can't be blank"
  end
end
