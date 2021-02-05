class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :email_exists, unless: -> { user.present? }
  validate :user_current?

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def email_exists
    if User.exists?(email: user_email.downcase)
      errors.add(:user_email, :taken)
    end
  end

  def user_current?
    if event.user.eql?(user)
      errors.add(:user, I18n.t('subscriptions.subscription.yourself_subscription'))
    end
  end
end
