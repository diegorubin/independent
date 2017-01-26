class Contact
  include Mongoid::Document

  field :name,       :type => String
  field :email,      :type => String
  field :body,       :type => String
  field :removed,    :type => Boolean,  :default => false

  # Validates
  validates_presence_of :name, :body, :email

  validates_format_of :email, 
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  after_create :send_notification

  private
  def send_notification
    # TODO: only with permissions
    admins = User.all
    admins.each do |user|
      NotifyContact.delay.notify(user, self)
    end
  end

end

