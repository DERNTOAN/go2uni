class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def edit?
    update?
  end

  def update?
    user.admin? || record == user
    # - record: the request passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

end
