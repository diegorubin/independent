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
  before_save    :generate_created_at

  def publish
    write_attribute(:published, true)
    save
  end

  def self.unpublisheds
    Hash[COMMENTABLES.collect{|c| [c, c.constantize.unpublished_comments.to_a]}]
  end

  private
  def generate_created_at
    unless created_at
      write_attribute(:created_at,Time.current)
    end
  end

end

