# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'create' do
    before do
      @user = FactoryBot.create(:user)
      @project = FactoryBot.create(:project, owner: @user)
      @task = @project.tasks.create!(name: 'Test task')
    end

    it 'responds with JSON formatted output' do
      new_task = { name: 'New test task' }
      sign_in @user
      expect do
        post :create, format: :json,
                      params: { project_id: @project.id, task: new_task }
      end.to change(@project.tasks, :count).by(1)
    end

    it 'requires authentication' do
      new_task = { name: 'New test task' }
      expect do
        post :create, format: :json,
                      params: { project_id: @project.id, task: new_task }
      end.not_to change(@project.tasks, :count)
      expect(response).not_to be_success
    end
  end
end
