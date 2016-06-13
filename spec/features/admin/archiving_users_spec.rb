require "rails_helper"

RSpec.feature "Admin can archive users" do

  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }

  before do
    login_as admin
  end

  scenario "successfully" do
    visit admin_user_path(user)
    click_link "Archive User"

    expect(page).to have_content "Successfully archived user"
    expect(page).not_to have_content user.email
  end

  scenario "but not themselves" do
    visit admin_user_path(admin)
    click_link "Archive User"

    expect(page).to have_content "Cannot archive yourself, that is dangerous"
    expect(page).to have_content admin.email
  end

end
