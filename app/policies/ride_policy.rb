class RidePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    user.admin? || record.user == user
  end

  def create?
    true
  end

end
