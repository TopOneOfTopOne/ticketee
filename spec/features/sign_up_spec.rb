require "rails_helper"

RSpec.feature "User can sign up" do
  scenario "with valid information" do
    visit "/"
    click_link "Sign Up"

    fill_in "Email", with: "example@test.com"
    fill_in "user_password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end
