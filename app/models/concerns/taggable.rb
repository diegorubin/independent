module Taggable
  extend ActiveSupport::Concern

  included do

    field :tags, type: String

    validates_format_of :tags, 
                        :with => /\A([^,]+,)*[^,]+\z/i,
                        :allow_blank => true
  end

end

