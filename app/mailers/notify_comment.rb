class NotifyComment < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: ActionMailer::Base.smtp_settings[:user_name]

  def notify(author, resource, comment_id)

    @author = author
    @resource = resource
    @comment = resource.comments.find(comment_id)

    mail to: author.email, 
      subject: I18n.t('mailer.notify_comment.subject')%(resource.title)
  end
end

