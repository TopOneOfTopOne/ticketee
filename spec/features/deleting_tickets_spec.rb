require 'rails_helper'

RSpec.feature "Deleting tickets" do

  let(:project) { FactoryGirl.create :project }
  let(:author) { FactoryGirl.create :user }
  let(:ticket) do
    FactoryGirl.create :ticket, project: project, author: author
  end

  before do
    assign_role! author, :manager, project
    login_as author
  end

  scenario "successfully" do
    visit project_ticket_path(project, ticket)

    click_link "Delete Ticket"

    expect(page).to have_content("Deleted ticket successfully")
  end

end
