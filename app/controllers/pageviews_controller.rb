class PageviewsController < ApplicationController

  def create
    resource = params[:resource_type].constantize.find(params[:resource_id])
    resource.increment_pageviews
    
    render text: 'ok'
  end

end

