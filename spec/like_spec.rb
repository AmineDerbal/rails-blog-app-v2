require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                     posts_counter: 0)
  post = user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0)
  subject { Like.new(author_id: user.id, post_id: post.id) }

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should belong to a user' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'should belong to a post' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  describe '#update_post_likes_counter' do
    it 'like increment' do
      expect(subject.post.likes_counters).to eq(1)
      subject.update_post_likes_counter
      expect(subject.post.likes_counters).to eq(2)
    end
  end
end
