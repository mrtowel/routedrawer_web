class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user_signed_in?
        can :manage, :all
    end
  end
end
