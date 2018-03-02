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
    user.admin? || record.user == user || record.passengers.map(&:id).include?(user.id)
  end

  def create?
    true
  end

end
