module Searchable
  extend ActiveSupport::Concern

  included do
    scope :filters, lambda { |params|
      options = {}
      options[:category] = params[:category] if params[:category]

      if params[:tag]
        options[:tags] = Regexp.new("(,|\\A)#{params[:tag].strip}(,|\\z)") 
      end

      if !params[:s].blank?
        options[:words_index.in] = (params[:s].split.collect{|w| w.no_accent.downcase } - STOPWORDS)
      end

      if params[:date]
        options[:date] = Regexp.new("^#{params[:date].strip}") 
      end

      options.length > 0 ? where(options) : {}
    }
  end

end

