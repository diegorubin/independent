module Admin::FilterFormHelper
  def render_filters_form(resource)
    form_tag('', method: 'get') do
      resource.admin_filters.collect do |name, attributes|
        render_filters_field(resource, name, attributes).html_safe
      end.join("\n").html_safe <<
      content_tag('div', '', class: 'clear') <<
      content_tag('div', class: 'filter-buttons') do
        button_tag(I18n.t('admin.forms.filters.clear'), type: 'reset', class: 'btn btn-default clear-filter-form') <<
        button_tag(I18n.t('admin.forms.filters.filter'), class: 'btn btn-default')
      end
    end
  end

  private
  def render_filters_field(resource, name, attributes)
    send("render_filters_#{attributes[:type]}_field", resource, name, attributes)
  end

  def render_filters_regex_field(resource, name, attributes)
    s = resource.name.underscore
    content_tag('div', {class: 'filter-field'}) do
      text = name.to_sym.t(:scope => [:mongoid, :attributes, s])
      label_tag("filters_#{name}", text) << 
      ": " <<
      text_field_tag("filters[#{name}]", params.fetch(:filters, {})[name])
    end
  end

  def render_filters_datetime_field(resource, name, attributes)
    s = resource.name.underscore

    if attributes[:interval]
      fields = ["#{name}_starts_in", "#{name}_ends_in"]
    else
      fields = [name]
    end

    content = ''
    fields.each do |field|
      content << content_tag('div', {class: 'filter-field'}) do
        text = field.to_sym.t(:scope => [:mongoid, :attributes, s])
        label_tag("filters_#{field}", text) << 
        ": " <<
        text_field_tag("filters[#{field}]", params.fetch(:filters, {})[field], class: 'datetime-filter')
      end
    end
    content
  end

end
