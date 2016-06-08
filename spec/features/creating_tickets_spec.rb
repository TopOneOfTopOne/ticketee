require 'rails_helper'

RSpec.feature "Creating tickets" do
  let(:user) { FactoryGirl.create :user }

  before do
    project = FactoryGirl.create(:project, name: "New project")

    login_as(user)

    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "With valid information" do
    fill_in "Name", with: "David Yu"
    fill_in "Description", with: "Smart Guy lol lol"
    click_button "Create Ticket"

    expect(page).to have_content("Successfully created ticket")
    expect(page).to have_content "Author: #{user.email}"
  end

  scenario "With invalid information" do
    click_button "Create Ticket"

    expect(page).to have_content("Failed to create ticket")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
  end
end
