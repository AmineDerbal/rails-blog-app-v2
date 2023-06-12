require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/15/posts'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('list of all posts and comment of a user')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/20/posts/1'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('details of a post')
    end
  end
end
