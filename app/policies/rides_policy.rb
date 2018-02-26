class RidesPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    true
  end

  def show?
    record.user == user
  end

  def create?
    true
  end

end
