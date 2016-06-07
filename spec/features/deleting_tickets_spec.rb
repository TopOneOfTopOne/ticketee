require 'rails_helper'

RSpec.feature "User attempts to delete ticket" do
  let(:project) { FactoryGirl.create :project }
  let(:ticket) { FactoryGirl.create :ticket, project: project }

  scenario "results in success" do
    visit project_ticket_path(project, ticket)

    click_link "Delete Ticket"

    expect(page).to have_content("Deleted ticket successfully")
  end
end
