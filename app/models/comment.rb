class Comment
  include Mongoid::Document
  include Gravtastic
  gravtastic :size => 60

  field :name,       :type => String
  field :site,       :type => String
  field :email,      :type => String
  field :body,       :type => String
  field :created_at, :type => DateTime
  field :published,  :type => Boolean,  :default => false
  field :removed,    :type => Boolean,  :default => false

  recursively_embeds_many

  embedded_in :commentable, :polymorphic => true

  # Validates
  validates_presence_of :name
  validates_presence_of :body

  validates_format_of :email, 
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # Callbacks
  before_save    :generate_created_at
  after_save     :generate_alert

  def publish
    write_attribute(:published, true)
    save
  end

  private
  def generate_created_at
    unless created_at
      write_attribute(:created_at,Time.current)
    end
  end

  def generate_alert
    return if removed
    _post = commentable
    _parent_comment = parent_comment

    until _post
      _post = _parent_comment.commentable
      _parent_comment = _parent_comment.parent_comment
    end

    CommentAlert.generate(id, _post, name, body) unless published
  end

end
