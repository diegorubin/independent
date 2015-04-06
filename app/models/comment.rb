class Comment
  include Mongoid::Document
  include Gravtastic

  COMMENTABLES = ['Post', 'Presentation']

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
  validates_presence_of :name, :body, :email

  validates_format_of :email, 
                      :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # Callbacks
  before_save  :generate_created_at
  after_create :send_notification

  def publish
    write_attribute(:published, true)
    update_item_list if save
  end

  def self.unpublisheds
    Hash[COMMENTABLES.collect{|c| [c, c.constantize.unpublished_comments.to_a]}]
  end

  def self.count_unpublisheds
    unpublisheds.collect{|c| c[1].length}.inject(0, :+)
  end

  private
  def generate_created_at
    unless created_at
      write_attribute(:created_at,Time.current)
    end
  end

  def update_item_list

    parent = find_parent(self)

    item = ListItem.where(
      {resource_type: parent.class.name , resource_id: parent.id.to_s}
    ).first

    return unless item

    item.update(number_of_comments: parent.number_of_comments)
  end

  def find_parent(comment)

    if comment.commentable.class.name != 'Comment'
      comment.commentable
    else
      find_parent(comment.commentable)
    end

  end

  def send_notification
    author = User.where(username: commentable.author).first
    NotifyComment.notify(author, commentable, self).deliver if author
  end

end

