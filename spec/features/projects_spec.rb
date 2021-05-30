# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :feature do
  it 'user creates a new project' do
    user = FactoryBot.create(:user)

    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect do
      click_link 'New Project'
      fill_in 'project[name]', with: 'Test Project'
      fill_in 'project[description]', with: 'Trying out Capybara'
      click_button 'Create Project'

      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content "Owner: #{user.name}"
    end.to change(user.projects, :count).by(1)
  end
end
