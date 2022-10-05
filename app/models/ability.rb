class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all

    can :manage, :all if user.role == 'admin'
    return unless user.present?

    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id
  end
end
