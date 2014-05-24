module ActAsDocument
  extend ActiveSupport::Concern

  def footnotes
    body.scan(/\[cite (.+)\]/).collect{|m| m.first}
  end

end

