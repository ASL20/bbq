class MailNotificationsJob < ApplicationJob
  queue_as :default

  def perform(model)
    event = model.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user&.email]).uniq

    if model.is_a?(Comment)
      all_emails.each { |mail| EventMailer.comment(event, model, mail).deliver_later }
    elsif model.is_a?(Photo)
      all_emails.each { |mail| EventMailer.photo(event, model, mail).deliver_later }
    else model.is_a?(Subscription)
      EventMailer.subscription(event, model).deliver_later
    end
  end
end
