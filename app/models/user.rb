class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, class_name: 'Post', foreign_key: :author_id
  has_many :comments, class_name: 'Comment', foreign_key: :author_id
  has_many :likes, class_name: 'Like', foreign_key: :author_id
  validates :name, presence: true
  validates :photo, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_create :generate_api_key

  def admin?
    role == 'admin'
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def generate_api_key
    api_key = loop do
      generated_api_key = SecureRandom.urlsafe_base64
      break generated_api_key unless User.exists?(api_key: generated_api_key)
    end

    update(api_key:)
  end
end
