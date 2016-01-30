class KindleMail < ActionMailer::Base

  default from: ActionMailer::Base.smtp_settings[:user_name]

  def send_book(bookfile, email)
    attachments['file.mobi'] = File.read bookfile
    mail to: email, subject: I18n.t('mailer.kindle.subject')
  end

end

