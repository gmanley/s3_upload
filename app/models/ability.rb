class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Album, user_id: user.id
      can :manage, Image, album: { user_id: user.id }
      can :read, :all
      cannot :read, Album, private: true
      can :read, Album, private: true, user_id: user.id
    else
      can :read, :all
      cannot :read, Album, private: true
    end
  end
end
