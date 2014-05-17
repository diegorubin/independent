xml.instruct!
     
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
     
    xml.title "Diego Rubin"
    xml.link request.protocol + request.host_with_port
    xml.pubDate @list_items.first.published_at.to_s(:rfc822) if @list_items.any?
    xml.description "Site pessoal de Diego Rubin"
     
    @list_items.each do |item|
      xml.item do
        xml.title         item.title
        xml.link          request.protocol + request.host_with_port + item_path(item)

        xml.description do
          xml.cdata! item.resume.from_markdown_to_html
        end

        item.tags.split(',').each do |tag|
          xml.category do
            xml.cdata! tag.strip
          end
        end

        xml.pubDate       item.published_at.to_s(:rfc822)
        xml.guid          item_path(item)
        xml.author        "rubin.diego@gmail.com (Diego Rubin)"
      end
    end
     
  end
end

