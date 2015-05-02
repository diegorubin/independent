class Admin::FiltersController < Admin::BaseController
  include ActionView::Context
  include ActionView::Helpers::FormTagHelper
  include Admin::FilterFormHelper
  
  def show
    respond_to do |format|
      format.html do
        klass = params[:id].constantize
        render layout: false, text: render_filters_form(klass)
      end
    end
  end

end

