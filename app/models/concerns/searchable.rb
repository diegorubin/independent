module Searchable
  extend ActiveSupport::Concern

  included do
    scope :filters, lambda { |params|
      options = {}
      options[:category] = params[:category] if params[:category]

      if params[:tag]
        options[:tags] = Regexp.new("(,|\\A)#{params[:tag]}(,|\\z)") 
      end

      options.length > 0 ? where(options) : {}
    }
  end

end

