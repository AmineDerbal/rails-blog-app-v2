require 'rails_helper'

RSpec.describe User, type: :model do
 
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
 

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
    let!(:post1) { user.posts.create(title: 'Post 1', text: 'This is post 1', comments_counter: 0, likes_counters: 0) }
    let!(:post2) { user.posts.create(title: 'Post 2', text: 'This is post 2', comments_counter: 0, likes_counters: 0) }
    let!(:post3) { user.posts.create(title: 'Post 3', text: 'This is post 3', comments_counter: 0, likes_counters: 0) }
    let!(:post4) { user.posts.create(title: 'Post 4', text: 'This is post 4', comments_counter: 0, likes_counters: 0) }
    
   
   it 'returns the most recent 3 posts' do
      recent_posts = user.recent_posts
      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to contain_exactly(post4, post3, post2)
    end

    it 'returns an empty array if the user has no posts' do
      user.posts.destroy_all
      recent_posts = user.recent_posts
      expect(recent_posts).to be_empty
    end
  end

end