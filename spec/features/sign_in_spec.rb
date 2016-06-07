require "rails_helper"

RSpec.feature "User can sign up" do
  let!(:user) { FactoryGirl.create :user }

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{user.email}")
  end
end
