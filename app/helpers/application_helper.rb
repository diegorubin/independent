module ApplicationHelper

  # Links helpers
  def return_if_active(controller_name, klass)
    klass if controller.controller_name == controller_name
  end

  # Url helpers
  def item_path(item, options = {})
    resource_path = item.resource_type.underscore
    args = [item.date, item.slug]
    send("#{resource_path}_path", *args, options)
  end

  # Render helpers
  def render_footnotes(items)

    result = content_tag :ul, class: 'footnotes' do
      list = items.collect.with_index do |item, i|
        li = content_tag :li  do
          l = link_to "[#{i+1}]", "#", name: "citation-#{i + 1}"
          l + ' ' + item.to_s
        end
        li
      end
      raw(list.join(''))
    end

    raw(result)
  end

end

