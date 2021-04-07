class EventPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def edit?
    user_is_owner?(record)
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    user_is_owner?(record)
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private
  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end
end
