class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, Post, public: true

    return unless user.present?  # additional permissions for logged in users (they can read their own posts)
    can :read, Post, user: user
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, author_id: user.id
    can :destroy, Post, id: user.posts.pluck(:id) # Grant permission to destroy posts that belong to the user

    return unless user.admin?  # additional permissions for administrators
    can :read, Post
    can :destroy, Post
    can :destroy, Comment

  
  end
end
