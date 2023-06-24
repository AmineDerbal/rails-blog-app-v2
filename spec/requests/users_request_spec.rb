require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    let(:user) do
      User.create(
        name: 'John',
        email: 'j@j.com',
        password: '123456',
        photo: 'j.jpg',
        bio: 'bio',
        posts_counter: 0,
        api_key: '123456',
        id: 1
      )
    end

    before do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      sign_in user # Sign in the user using Devise
    end


    before(:each) do
      get '/users'
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
    it 'include the list of users' do
      expect(response.body).to include('The list of users')
    end
  end

  describe 'GET /show' do
    let(:user) do
      User.create(
        name: 'Tom',
        email: 't@t.com',
        password: '123456',
        photo: 'j.jpg',
        bio: 'bio',
        posts_counter: 0,
        api_key: '123456',
        id: 1
      )
    end

    before do
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      sign_in user # Sign in the user using Devise
    end

    before(:each) do
      get '/users/1'
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
    it 'include the details of a user' do
      expect(response.body).to include('User name with posts')
    end
  end
end
