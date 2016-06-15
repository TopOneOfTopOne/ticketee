require 'rails_helper'

RSpec.feature "hidden links" do
  let(:admin) { FactoryGirl.create :user, :admin }
  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project }

  context "anonymous user" do
    it "should not show hidden links" do
      visit "/"

      expect(page).to_not have_link "New Project"

      # There is no need for this since there is already a test to stop anonymous users
      # from viewing projects which they do not have a role in
      # ./spec/policies/project_policy_spec.rb
        # visit project_path(project)
        # expect(page).to_not have_link "Delete"
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
    end
  end

  context "logged in admin" do
    before { login_as admin }

    it "should show hidden links" do
      visit "/"
      expect(page).to have_link "New Project"

      visit project_path(project)
      expect(page).to have_link "Delete"
    end
  end
end
