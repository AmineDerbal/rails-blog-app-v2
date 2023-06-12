require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:each) do
      get '/users/15/posts'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'return 200' do
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      expect(response).to render_template('index')
    end
    it 'include the list of all posts and comment of a user' do
      expect(response.body).to include('list of all posts and comment of a user')
    end
  end

  describe 'GET /show' do
    before(:each) do
      get '/users/20/posts/1'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'return 200' do
      expect(response.status).to eq(200)
    end
    it 'renders the show template' do
      expect(response).to render_template('show')
    end
    it 'include the details of a post' do
      expect(response.body).to include('details of a post')
    end
  end
end
