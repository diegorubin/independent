class FiltersController < SiteController

  def index
    @search = params.fetch(:s, '').split.join('|')
    @list_items = ListItem.filters(params).ordered_by_published_at
    respond_to do |format|
      format.html do
        @list_items = @list_items.page(params.fetch(:page, 1))
      end
      format.json do
        render json: @list_items.to_json
      end
    end
  end

end

