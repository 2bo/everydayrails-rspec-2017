# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  context 'as an authenticated user' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'with valid attributes' do
      it 'adds a project' do
        project_attributes = FactoryBot.attributes_for(:project)
        sign_in @user
        expect do
          post projects_path, params: { project: project_attributes }
        end.to change(@user.projects, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not add a project' do
        project_attributes = FactoryBot.attributes_for(:project, :invalid)
        sign_in @user
        expect do
          post projects_path, params: { project: project_attributes }
        end.not_to change(@user.projects, :count)
      end
    end
  end
end
