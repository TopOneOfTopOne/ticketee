require "rails_helper"

RSpec.feature "User can sign up" do
  let!(:user) { FactoryGirl.create :user }

  before do
    visit "/"
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
  end

  scenario "with valid credentials" do
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{user.email}")
  end

  scenario "but not when account is archived" do
    user.archive

    click_button "Log in"

    expect(page).to have_content("Account archived")
    expect(page).to_not have_content("Signed in as #{user.email}")
  end
end
