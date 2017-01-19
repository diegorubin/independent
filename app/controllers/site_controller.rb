class SiteController < ApplicationController
  include WidgetsRecover
  include CommentForm

  layout :set_current_theme
  prepend_before_filter :prepend_view_paths

  before_filter :widgets, :show_comment_form

end

