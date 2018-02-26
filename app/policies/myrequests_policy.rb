class MyrequestsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    record.user == user
  end

  def show?
    record.user == user
  end
end
