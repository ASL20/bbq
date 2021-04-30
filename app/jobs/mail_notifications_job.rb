class MailNotificationsJob < ApplicationJob
  queue_as :default

  def perform_later(event, type)
    # собираем всех подписчиков и автора события в массив мэйлов, исключаем повторяющиеся
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [current_user&.email]).uniq

    # XXX: Этот метод может выполняться долго из-за большого числа подписчиков
    # поэтому в реальных приложениях такие вещи надо выносить в background задачи!
    case type
    when Subscription
      EventMailer.subscription(event, type).deliver_later
    when Comment
      all_emails.each do |mail|
        EventMailer.comment(event, type, mail).deliver_later
      end
    when Photo
      all_emails.each do |mail|
        EventMailer.photo(event, type, mail).deliver_later
      end
    end
  end
end
