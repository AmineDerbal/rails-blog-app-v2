 require 'swagger_helper'

RSpec.describe 'Comments API', type: :request do
  let(:user) { User.create(name: 'John', email: 'j@j.com', password: '123456', photo: 'j.jpg', bio: 'bio', posts_counter: 0, api_key: '123456') }
  let(:faux_post) { Post.create(title: 'Post 1', text: 'Post 1', comments_counter: 0, likes_counters: 0, author_id: user.id) }

  before do
    allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
  end

  describe 'GET Comments' do
    let(:comment) { Comment.create(text: 'Hello!', post_id: faux_post.id, author_id: user.id) }
    before(:each) do
      get "/api/users/#{user.id}/posts/#{faux_post.id}/comments"
    end

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Post Comments' do
 
    before(:each) do
      headers = {'X-Api-Key' => user.api_key }
      post "/api/users/#{user.id}/posts/#{faux_post.id}/comments", :params => { :comment => {:text => 'Hello!'} }, :headers => headers
    end
   

   it 'returns http success' do
     expect(response).to have_http_status(201)
   end

  end

end