require 'rails_helper'

RSpec.feature "Users can edit tickets" do
  let(:default_project) { FactoryGirl.create :project }
  let(:author) { FactoryGirl.create :user }
  let(:default_ticket) do
    FactoryGirl.create :ticket, project: default_project, author: author
  end

  before do
    assign_role! author, :editor, default_project
    login_as author
    visit project_ticket_path(default_project, default_ticket)
    click_link "Edit Ticket"
  end

  scenario "successfully" do
    fill_in "Name", with: "New name"
    fill_in "Description", with: "New description here."
    click_button "Update Ticket"

    expect(page).to have_content "Updated ticket successfully"
    expect(page).to have_content "New name"
    expect(page).to have_content "New description here"
  end

  scenario "but not with missing data" do
    fill_in "Name", with: ""
    click_button "Update Ticket"

    expect(page).to have_content "Failed to update ticket"
  end
end
