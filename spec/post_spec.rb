require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Title', text: 'Text', comments_counter: 0, likes_counters: 0) }

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'likes_counters should be an integer' do
    subject.likes_counters = 'a'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counters should be greater than or equal to 0' do
    subject.likes_counters = -1
    expect(subject).to_not be_valid
  end

  describe '#update_user_posts_counter' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
    let!(:post) { user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0) }

    it 'user_counter' do
      user.increment!(:posts_counter)
      expect(user.posts_counter).to eq(1)
    end
  end

  describe '#recent_comments' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
    let!(:post) { user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0) }
    let!(:comment1) { post.comments.create(text: 'Comment 1', author_id: user.id) }
    let!(:comment2) { post.comments.create(text: 'Comment 2', author_id: user.id) }
    let!(:comment3) { post.comments.create(text: 'Comment 3', author_id: user.id) }
    let!(:comment4) { post.comments.create(text: 'Comment 4', author_id: user.id) }
    let!(:comment5) { post.comments.create(text: 'Comment 5', author_id: user.id) }
    let!(:comment6) { post.comments.create(text: 'Comment 6', author_id: user.id) }

    it 'returns the most recent 3 comments' do
      recent_comments = post.recent_comments
      expect(recent_comments.length).to eq(3)
      expect(recent_comments).to contain_exactly(comment6, comment5, comment4)
    end

    it 'returns an empty array if the post has no comments' do
      post.comments.destroy_all
      recent_comments = post.recent_comments
      expect(recent_comments).to be_empty
    end
  end
end
