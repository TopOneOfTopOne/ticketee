require 'rails_helper'

RSpec.feature "users can view tickets" do
  let!(:project) { FactoryGirl.create :project }
  let!(:author1) { FactoryGirl.create :user }
  let!(:author2) { FactoryGirl.create :user }
  let!(:ticket1) { FactoryGirl.create :ticket, project: project, author: author1 }
  let!(:ticket2) { FactoryGirl.create :ticket, name: "ticket2 name", project: project, author: author2 }

  before do
    assign_role!(author1, :viewer, project)
    login_as author1
    visit "/"
  end

  scenario "user trying to view ticket for given project" do
    click_link "project name"

    expect(page).to have_content("ticket name")
    expect(page).to have_content("ticket2 name")

    click_link "ticket name"

    expect(page).to have_content("ticket name")
    expect(page).to have_content("project name")
    expect(page).to have_content("ticket description")
  end
end
