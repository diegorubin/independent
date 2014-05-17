class FeedsController < ApplicationController

  def index

    @list_items = ListItem.filters(params).ordered_by_published_at.
      limit(20)

    respond_to do |format|
      format.rss  { render :layout => false }
      format.html { render :layout => false, 
                    :template => "feeds/index.rss.builder" }

    end
    
  end

end

