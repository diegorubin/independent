class Tag
  include Mongoid::Document

  field :name, :type => String

  embeds_many :list_contents, :as => :listable

  index(
    [
      [:name, Mongo::DESCENDING]
    ],
    :unique => true
  )

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

  class << self
    
    def generate_list
      posts = Post.where(:published => true)
      presentations = Presentation.where(:published => true)
      bookmarks = Bookmark.where(:public => true)
      snippets = Snippet.where(:public => true)

      contents = posts + presentations + bookmarks + snippets
      contents = contents.sort_by {|c| c.updated_at}.reverse

      # XXX: Melhorar essa abordagem assim q possivel
      Tag.destroy_all
      contents.each do |content|
        content.tags.split(',').each do |tag|
          m_tag = Tag.find_or_initialize_by(:name => tag.strip)
          
          c = m_tag.list_contents.find_or_initialize_by(:content_id => content.id.to_s,
                                                 :content_class => content.class.to_s)

          c.title = content.title
          c.resume = content.resume
          c.updated_at = content.updated_at
          c.tags = content.tags

          case content.class.to_s
          when "Post"
            c.link = "/#{content.date}/#{content.slug}"
          when "Presentation"
            c.link = "/presentation/#{content.slug}"
            c.image = content.slides.first.file.thumb.url
          when "Bookmark"
            c.link = content.link
          when "Snippet"
            c.link = "/snippet/#{content.slug}"
          end

          m_tag.save
        end
      end

    end

  end

end
