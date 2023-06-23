require 'swagger_helper'

RSpec.describe 'api/posts', type: :request do
  path '/api/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    let(:user) { User.create(name: 'John', email: 'j@j.com', password: '123456', photo: 'j.jpg', bio: 'bio', posts_counter: 0, api_key: '123456') }

    before do
      # Skip Devise confirmation to avoid missing host error
      allow_any_instance_of(User).to receive(:confirmed?).and_return(true)
      Post.create(title: 'Post 1', text: 'Post 1', comments_counter: 0, likes_counters: 0, author_id: user.id)
      Post.create(title: 'Post 2', text: 'Post 2', comments_counter: 0, likes_counters: 0, author_id: user.id)
    end

    get('list posts') do
      response(200, 'successful') do
        let(:user_id) { user.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do
          expect(JSON.parse(response.body, symbolize_names: true).size).to eq(2)
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
