require "rails_helper"

RSpec.feature "Admin can change user's details" do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }

  before do
    login_as admin
    visit admin_user_path(user)
    click_link "Edit User"

    fill_in "Email", with: "changed@email.com"
  end

  scenario "with valid credentials" do
    click_button "Update User"

    expect(page).to have_content "Successfully edited user"
    expect(page).to_not have_content user.email
    expect(page).to have_content "changed@email.com (User)"
  end

  scenario "when toggling user's admin ability" do
    check "Is an admin?"

    click_button "Update User"
    expect(page).to have_content "Successfully edited user"
    expect(page).to have_content "changed@email.com (Admin)"
  end
end
