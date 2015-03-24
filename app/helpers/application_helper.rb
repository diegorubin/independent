module ApplicationHelper

  def render_gplus
    raw %q{
      <script type="text/javascript">
        window.___gcfg = {lang: 'pt-br'};
        (function() 
        {var po = document.createElement("script");
        po.type = "text/javascript"; po.async = true;po.src = "https://apis.google.com/js/plusone.js";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(po, s);
        })();
      </script>
    }
  end

  # Links helpers
  def return_if_active(controller_name, klass)
    klass if controller.controller_name == controller_name
  end

  # Url helpers
  def item_path(item, options = {})
    resource_path = item.resource_type.underscore
    args = [item.date || '0000/00/00', item.slug || 'preview']
    send("#{resource_path}_path", *args, options).gsub('%2F', '/')
  end

  # Render helpers
  def render_comment(comment)
    comment = h(comment)
    comment.gsub!(/[^\s]+\/[^\s]*/) do |link|
      link =~ /(https?:\/\/)/i
      href = $1 ? link : "http://" + link
      link_to link, href
    end
    raw(comment.gsub(/\A/,'<p>').
            gsub(/\n/,'</p><p>').
            gsub(/\z/,'</p>'))
  end

  def render_name(name, site, email = "")
    infos = name
    infos += " - #{email}" if user_signed_in?
    return infos if site.blank?
    link_to infos, site, target: "blank", rel: "external nofollow"
  end

  def render_footnotes(items)

    return '' if items.empty?

    result = content_tag :h2 do :footnotes.t end

    result += content_tag :div, class: 'footnotes' do
      list = items.collect.with_index do |item, i|
        p = content_tag :p  do
          span = content_tag :span  do
            link_to "[#{i+1}]", "#", name: "citation-#{i + 1}"
          end
          span + " " + raw(item.to_s.gsub(/<\/?p>/,''))
        end
        p
      end
      raw(list.join(''))
    end

    raw(result)
  end

end

