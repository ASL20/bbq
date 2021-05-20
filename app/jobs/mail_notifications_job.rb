class MailNotificationsJob < ApplicationJob
  queue_as :default

  def perform(model)
    event = model.event
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user&.email]).uniq

    case model
    when Comment
      all_emails.each { |mail| EventMailer.comment(event, model, mail).deliver_later }
    when Photo
      all_emails.each { |mail| EventMailer.photo(event, model, mail).deliver_later }
    when Subscription
      EventMailer.subscription(event, model).deliver_later
    end
  end
end
