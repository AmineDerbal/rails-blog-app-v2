require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0)
  post = user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0)
subject { Comment.new(text: 'Text', author_id: user.id, post_id: post.id) }

before { subject.save }

it 'text should be present' do
  subject.text = nil
  expect(subject).to_not be_valid
end

it 'author_id should be present' do
  subject.author_id = nil
  expect(subject).to_not be_valid
end

it 'post_id should be present' do
  subject.post_id = nil
  expect(subject).to_not be_valid
end

describe '#update_post_comments_counter' do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
  let!(:post) { user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0) }
  let!(:comment) { post.comments.create(text: 'Comment 1', author_id: user.id) }
  
  it 'user_counter' do
    user.increment!(:posts_counter)
    expect(user.posts_counter).to eq(1)
  end
end
end