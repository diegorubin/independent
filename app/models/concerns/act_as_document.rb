module ActAsDocument
  extend ActiveSupport::Concern

  def footnotes
    body.scan(/\[cite ((.|\n)+?)\]/).collect{|m|
      m.first.from_markdown_to_html
    }
  end

end

