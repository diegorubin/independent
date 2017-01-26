class NotifyContact < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  default from: ActionMailer::Base.smtp_settings[:user_name]

  def notify(user, contact)

    @user = user 
    @contact = contact

    mail to: user.email, 
      subject: I18n.t('mailer.notify_contact.subject')
  end
end

