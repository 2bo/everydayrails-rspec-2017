# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :feature do
  it 'user creates a new project' do
    user = FactoryBot.create(:user)
    sign_in user
    visit root_path

    expect do
      click_link 'New Project'
      fill_in 'project[name]', with: 'Test Project'
      fill_in 'project[description]', with: 'Trying out Capybara'
      click_button 'Create Project'
    end.to change(user.projects, :count).by(1)

    expect(page).to have_content 'Project was successfully created'
    expect(page).to have_content 'Test Project'
    expect(page).to have_content "Owner: #{user.name}"
  end
end
