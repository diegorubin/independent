class Tag
  include Mongoid::Document

  field :name, :type => String

  embeds_many :list_contents, :as => :listable

  # Scopes
  scope :ordered_by_name, lambda {
    order_by([["name","asc"]])
  }

  def posts
    return @posts if @posts

    @posts = []
    postids.each do |_id|
      @posts << Post.find(_id)
    end
    @posts
  end

  def size
    posts.size
  end

end

