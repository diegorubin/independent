class NotifyComment < ActionMailer::Base
  default from: ActionMailer::Base.smtp_settings[:user_name]

  def notify(author, resource, comment)
    @author = author
    @resource = resource
    @comment = comment

    mail to: author.email, 
      subject: I18n.t('mailer.notify_comment.subject')%(resource.title)
  end
end

