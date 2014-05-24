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

    return '' if items.empty?

    result = content_tag :h2 do :footnotes.t end

    result += content_tag :dl, class: 'dl-horizontal footnotes' do
      list = items.collect.with_index do |item, i|
        dt = content_tag :dt  do
          link_to "[#{i+1}]", "#", name: "citation-#{i + 1}"
        end
        dd = content_tag :dd  do
          raw(item.to_s)
        end
        dt + dd
      end
      raw(list.join(''))
    end

    raw(result)
  end

end

