class Ability
  include CanCan::Ability

  def initialize(user)
    if user # Registered user?
      can :manage, Album, user_id: user.id # Can manage any album they own
      can :manage, Image, album: { user_id: user.id } # Can manage any image in an album they own
      can :manage, User, id: user.id # Can umm manage themselves??
      can :read, :all # Can read anything ...
      cannot :read, Album, private: true # except albums that are private ...
      can :read, Album, private: true, user_id: user.id # unless they own the album
    else # Guest
      can :create, User # Can register a user
      can :read, :all # Can read anything ...
      cannot :read, Album, private: true # except albums that are private
      cannot :read, Image, album: { private: true } # or images whose album is private
    end
  end
end
