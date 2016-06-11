require "rails_helper"

RSpec.feature "creating users with admin" do
  let(:admin) { FactoryGirl.create :user, :admin }

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
  end
end
