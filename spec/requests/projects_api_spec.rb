# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProjectApis', type: :request do
  it 'loads a project' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project,
                      name: 'Sample Sample Project')
    FactoryBot.create(:project,
                      name: 'Second Sample Project',
                      owner: user)

    get api_projects_path, params: {
      user_email: user.email,
      user_token: user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 1
    project_id = json[0]['id']

    get api_project_path(project_id), params: {
      user_email: user.email,
      user_token: user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)

    expect(json['name']).to eq 'Second Sample Project'
  end

  it 'creates a project' do
    # uesr作成
    user = FactoryBot.create(:user)
    # project_attributeを作成
    project_attributes = FactoryBot.attributes_for(:project)
    # apiにアクセス
    expect do
      post api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token,
        project: project_attributes
      }
    end.to change(user.projects, :count).by(1)
    # createdが帰っていることを確認
    expect(response).to have_http_status(:success)
  end
end
