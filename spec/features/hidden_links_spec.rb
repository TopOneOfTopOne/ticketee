require 'rails_helper'

RSpec.feature "Show correct links for" do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project }

  context "anonymous user" do
    it "should not show hidden links" do
      visit "/"

      expect(page).to_not have_link "New Project"

        visit project_path(project)
        expect(page).to_not have_link "Delete"
    end
  end

  context "logged in user" do
    before do
      assign_role! user, :viewer, project
      login_as user
    end

    it "should not show hidden links" do
      visit "/"
      expect(page).to_not have_link "New Project"

      visit project_path(project)
      expect(page).to_not have_link "Delete"
      expect(page).to_not have_link "Edit"
      expect(page).to_not have_link "New Ticket"
    end
  end

  context "logged in admin" do
    before { login_as admin }

    it "should show hidden links" do
      visit "/"
      expect(page).to have_link "New Project"

      visit project_path(project)
      expect(page).to have_link "Delete"
      expect(page).to have_link "Edit"
      expect(page).to have_link "New Ticket"
    end
  end
end
