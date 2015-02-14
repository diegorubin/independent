class ImagesInput
  include Formtastic::Inputs::Base
  include ActionView::Helpers::FormTagHelper

  def input_html_options
    super
  end

  def to_html
    label_html << 
    search_html << 
    builder.hidden_field(method, input_html_options)
  end

  private
  def label_html
    label_tag(:search.t(scope: ['image']) + ':')
  end

  def search_html
    text_field_tag('search', '', {class: '.search-images'})
  end

end

