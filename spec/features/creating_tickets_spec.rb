require 'rails_helper'

RSpec.feature "Can create tickets" do
  let(:user) { FactoryGirl.create :user }

  before do
    project = FactoryGirl.create(:project, name: "New project")
    assign_role! user, :editor, project
    login_as(user)

    visit project_path(project)
    click_link "New Ticket"
  end

  scenario "with valid information" do
    fill_in "Name", with: "David Yu"
    fill_in "Description", with: "Smart Guy lol lol"
    click_button "Create Ticket"

    expect(page).to have_content("Successfully created ticket")
    expect(page).to have_content "Author: #{user.email}"
  end

  scenario "unless invalid information" do
    click_button "Create Ticket"

    expect(page).to have_content("Failed to create ticket")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  # scenario "with multiple attachments", js: true do
  #   fill_in "Name", with: "A ticket"
  #   fill_in "Description", with: "the ticket description"
  #
  #   attach_file "File #1", "spec/fixtures/sampleText.txt"
  #   click_link "Add another file"
  #
  #   attach_file "File #2", "spec/fixtures/sampleText2.txt"
  #   click_link "Add another file"
  #
  #   attach_file "File #3", "spec/fixtures/sampleText3.txt"
  #
  #   click_button "Create Ticket"
  #
  #   expect(page).to have_content("Successfully created ticket")
  #   expect(page).to have_content("sampleText.txt")
  #   expect(page).to have_content("sampleText2.txt")
  #   expect(page).to have_content("sampleText3.txt")
  # end

  scenario "uploaded file persists when re-rendering" do
    attach_file "File #1", "spec/fixtures/sampleText.txt"
    click_button "Create Ticket"

    fill_in "Name", with: "A ticket"
    fill_in "Description", with: "the ticket description"

    click_button "Create Ticket"

    expect(page).to have_content("Successfully created ticket")
    expect(page).to have_content("sampleText.txt")
  end
end
