class WelcomeController < SiteController

  def index
    @list_items = ListItem.ordered_by_published_at.
      page(params.fetch(:page, 1))
  end

end

