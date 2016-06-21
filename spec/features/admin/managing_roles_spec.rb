require "rails_helper"

RSpec.feature "Admin's can assign user roles" do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }
  let!(:project1) { FactoryGirl.create :project, name: "project1" }
  let!(:project2) { FactoryGirl.create :project, name: "project2" }

  before do
    login_as admin
  end
  scenario "When user is an existing user" do
    visit admin_user_path(user)
    click_link "Edit User"

    select "Viewer", from: "project1"
    select "Manager",from: "project2"

    click_button "Update User"
    click_link user.email

    expect(page).to have_content "project1: Viewer"
    expect(page).to have_content "project2: Manager"
  end
end
