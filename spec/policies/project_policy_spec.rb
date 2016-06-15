require 'rails_helper'

RSpec.describe ProjectPolicy do

  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it "blocks anonymous user" do
      expect(subject).to_not permit(nil, project)
    end

    it "allows veiwers of the project" do
      assign_role!(user, :viewer, project)
      expect(subject).to permit(user, project)
    end

    it "allows editors of the project" do
      assign_role!(user, :editor, project)
      expect(subject).to permit(user, project)
    end

    it "allows managers of the project" do
      assign_role!(user, :manager, project)
      expect(subject).to permit(user, project)
    end

    it "allows administrators of the project" do
      admin = FactoryGirl.create :user, :admin
      expect(subject).to permit(admin, project)
    end

    it "doesn't allow users assigned to other projects" do
      other_project = FactoryGirl.create :project
      assign_role!(user, :viewer, other_project)
      expect(subject).to_not permit(user, project)
    end
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
