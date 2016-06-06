require 'rails_helper'

RSpec.feature "users can view tickets" do
  before do
    default_project = FactoryGirl.create :project

    default_ticket = FactoryGirl.create :ticket, project: default_project
    ticket1        = FactoryGirl.create(:ticket, name: "ticket1 name",
                                        project: default_project,
                                        description: "ticket1 description.")
    visit "/"
  end

  scenario "user trying to view ticket for given project" do
    click_link "project name"

    expect(page).to have_content("ticket name")
    expect(page).to have_content("ticket1 name")

    click_link "ticket name"

    expect(page).to have_content("ticket name")
    expect(page).to have_content("project name")
    expect(page).to have_content("ticket description")
  end
end
