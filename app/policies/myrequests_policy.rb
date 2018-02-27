class MyrequestsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || record.user == user
  end

  def show?
    user.admin? || record.user == user
  end
end
