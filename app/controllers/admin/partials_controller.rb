class Admin::PartialsController < Admin::BaseController
  def index

    parent = params[:parent]
    attrs = parent.underscore.pluralize

    object = params[:klass].constantize.new
    index = Time.now.to_i

    form = Formtastic::FormBuilder.new(
      "#{parent}[#{attrs}_attributes][#{index}]", 
      object, self, {})

    render partial: params[:partial], locals: {e: form}
  end
end

