class EventPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  def show?
    record.pincode.blank? ||
      user_is_owner?(record) ||
      record.pincode_valid?(cookies["events_#{record.id}_pincode"])
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
