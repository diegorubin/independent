class WelcomeController < SiteController

  def index
    list_items = ListItem.ordered_by_published_at
    if is_multiple_domains_enabled?
      list_items = list_items.filter_by_domain(current_domain)
    end
    @list_items = list_items.page(params.fetch(:page, 1))
  end

end

