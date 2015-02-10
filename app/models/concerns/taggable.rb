module Taggable
  extend ActiveSupport::Concern

  included do

    field :tags, type: String

    validates_format_of :tags, 
                        :with => /\A([^,]+,)*[^,]+\z/i,
                        :allow_blank => true

    def self.for_tag(tag)
      where(tags: /\b#{tag}\b/i)
    end

  end

  def tags_list
    @tags_list ||= tags.split(',').collect{ |t| t.strip }
  end

end

