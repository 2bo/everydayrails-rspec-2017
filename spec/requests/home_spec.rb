# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  it 'respones successfully' do
    get root_path
    expect(response).to be_success
    expect(response).to have_http_status(:success)
  end
end
