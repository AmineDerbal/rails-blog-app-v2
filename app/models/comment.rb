class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post', foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :text, presence: true

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter_after_destroy

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end

  def update_post_comments_counter_after_destroy
    post.decrement!(:comments_counter)
  end
end
