 require 'swagger_helper'

# RSpec.describe 'Comments API', type: :request do
#   path '/api/users/{user_id}/posts/{post_id}/comments' do
#     parameter name: 'user_id', in: :path, type: :string, description: 'User ID'
#     parameter name: 'post_id', in: :path, type: :string, description: 'Post ID'

#     let(:user) { User.create(name: 'John', email: 'j@j.com', password: '123456', photo: 'j.jpg', bio: 'bio', posts_counter: 0, api_key: '123456') }
#     let(:post) { Post.create(title: 'Post 1', text: 'Post 1', comments_counter: 0, likes_counters: 0, author_id: user.id) }
#     let(:comment) { Comment.create(text: 'Hello!', post_id: post.id, author_id: user.id) }

#     before do
#       allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
#     end
 

#     get 'Get all comments' do
#       tags 'Comments'
#       produces 'application/json'

#       response '200', 'successful' do
#         let(:user_id) { user.id }
#         let(:post_id) { post.id } 
#         run_test! do |response|
#           expect(response).to have_http_status(200)
#         end
#       end
#     end

#     post 'Creates a comment' do
#       tags 'Comments'
#       consumes 'application/json'
#       parameter name: :comment1, in: :body, schema: {
#         type: :object,
#         properties: {
#           text: { type: :string }
#         },
#         required: ['text']
#       }
      

#       response '201', 'Created' do
#         let(:user_id) { user.id }
#         let(:post_id) { post.id }
#         let(:comment1) { { text: 'Hello!' } }
#         let(:headers) { { 'X-Api-Key' => user.api_key } }
#         before do
#            request.headers.merge!(headers)
#           # post "/api/users/#{user_id}/posts/#{post_id}/comments", params: comment1
#           # puts response.body
#         end
#         run_test!
    
#         # it 'returns a 201 response' do
#         #   expect(response).to have_http_status(201)
#         # end
    
#         # it 'creates a comment' do
#         #   data = JSON.parse(response.body)
#         #   expect(data['text']).to eq('Hello!')
#         # end
       
#       end
#     end
#   end
# end

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