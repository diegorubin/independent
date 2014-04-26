class SnippetsController < ApplicationController

  def show
    @snippet = Snippet.by_slug(params[:slug]).where(:public => true).first
    raise SnippetNotFound if @snippet.nil?

  end

  def index
    @snippets = Snippet.where(:public => true).
                  ordered_by_published_at.
                  page(params.fetch(:page,1)) 

  end

end
