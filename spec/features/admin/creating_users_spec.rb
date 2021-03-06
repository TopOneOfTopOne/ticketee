require "rails_helper"

RSpec.feature "creating users with admin" do
  let(:admin) { FactoryGirl.create :user, :admin }
  let!(:project) { FactoryGirl.create :project, name: "project name" }

  before do
    login_as admin
    visit "/"
    click_link "Admin"
    click_link "Users"
    click_link "New User"
  end

  scenario "successfully with valid credentials" do
    fill_in "Email", with: "example@test.com"
    fill_in "Password", with: "password"

    click_button "Create User"

    expect(page).to have_content "Successfully created user"
    expect(page).to have_content "example@test.com (User)"
  end

  scenario "successfully + creates another admin" do
    fill_in "Email", with: "admin@test.com"
    fill_in "Password", with: "password"
    check "Is an admin?"

    click_button "Create User"

    expect(page).to have_content "Successfully created user"
    expect(page).to have_content "admin@test.com (Admin)"
  end

  scenario "when assigning user a role" do
    fill_in "Email", with: "example@test.com"
    fill_in "Password", with: "password"
    select "Manager", from: "project name"

    click_button "Create User"

    expect(page).to have_content "Successfully created user"
    click_link "example@test.com"

    expect(page).to have_content "project name: Manager"
  end
end
