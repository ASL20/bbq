class MailNotificationsJob < ApplicationJob
  queue_as :default

  def perform(type)
    event = type.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [type.user&.email]).uniq

    if type.is_a?(Comment)
      all_emails.each { |mail| EventMailer.comment(event, type, mail).deliver_later }
    elsif type.is_a?(Photo)
      all_emails.each { |mail| EventMailer.photo(event, type, mail).deliver_later }
    else type.is_a?(Subscription)
      EventMailer.subscription(event, type).deliver_later
    end
  end
end
