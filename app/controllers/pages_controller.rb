class PagesController < SiteController

  def show
    @page = Page.publisheds.find_by_simple_slug(params[:slug]).first
    respond_to do |format|
      format.html {}
      format.json do
        @page.body = @page.body.from_markdown_to_html
        render json: @page.to_json
      end
    end
  end

end

