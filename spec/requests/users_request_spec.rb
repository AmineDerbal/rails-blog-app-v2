require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('The list of users')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/1'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('User name with posts')
    end
  end
end
