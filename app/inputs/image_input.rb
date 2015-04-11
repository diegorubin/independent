class ImageInput
  include Formtastic::Inputs::Base
  include Formtastic::Inputs::Base::Wrapping

  def to_html
    form_group_wrapping do
      label_html << 
      template.content_tag(:span, class: 'form-wrapper') do

        options = {class: 'image-select-content'}
        options['data-image-size'] = input_html_options['data-image-size'] || 'small'

        template.content_tag(:div, '', {class: 'modal-select'}) <<
        template.content_tag(:div, '', options) <<
        builder.hidden_field(method, input_html_options)
      end
    end
  end

  def label_html_options
    super.tap do |options|
      options[:class] = options[:class].reject { |c| c == 'label' }
      options[:class] << " control-label"
    end
  end

  private
  def form_group_wrapping(&block)
    template.content_tag(:div,
      template.capture(&block).html_safe,
      {'data-image-select' => 'on'}.merge(wrapper_html_options)
    )
  end

  def wrapper_html_options
    super.tap do |options|
      options[:class] << " form-group"
      options[:class] << " has-error" if errors?
    end
  end

end

