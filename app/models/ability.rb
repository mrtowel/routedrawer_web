class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.role == User::ROLES[:admin]
    cannot :edit, :locations unless user.role == User::ROLES[:admin]
  end
end
