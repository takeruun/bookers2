class EventMailMailer < ApplicationMailer
  def send_mail(to_mails, event_mail)
    @event_mail = event_mail

    mail to: to_mails, subject: 'Event'
  end
end