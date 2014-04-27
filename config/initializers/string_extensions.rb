module StringExtensions

  CHARS_WITH_ACCENTS = [
    [/\xC3\xA0/,  'a'], [/\xC3\xA1/,  'a'], [/\xC3\xA2/,  'a'], 
    [/\xC3\xA3/,  'a'], [/\xC3\xA9/,  'e'], [/\xC3\xAA/,  'e'],
    [/\xC3\xAD/,  'i'], [/\xC3\xB3/,  'o'], [/\xC3\xB4/,  'o'],
    [/\xC3\xB5/,  'o'], [/\xC3\xBA/,  'u'], [/\xC3\xBC/,  'u'],
    [/\xC3\xA7/,  'c'], [/\xC3\x80/,  'A'], [/\xC3\x81/,  'A'],
    [/\xC3\x82/,  'A'], [/\xC3\x83/,  'A'], [/\xC3\x89/,  'E'],
    [/\xC3\x8A/,  'E'], [/\xC3\x8D/,  'I'], [/\xC3\x93/,  'O'],
    [/\xC3\x94/,  'O'], [/\xC3\x95/,  'O'], [/\xC3\x9A/,  'U'],
    [/\xC3\x9C/,  'U'], [/\xC3\x87/,  'C']
  ]


  def from_markdown_to_html
    # Minha "extensao" do markdown
    r = self.gsub(/\[render_snippet (.+)\]/) do |snippet|
      s = Snippet.by_slug($1).first
      s ? s.to_html : "Snippet não encontrado"
    end
    BlueCloth::new(r).to_html
  end

  def sanitize(options = {})
    options[:tags] ||= []
    ActionController::Base.helpers.sanitize(self, options)
  end

  def no_accent
    str = self
    CHARS_WITH_ACCENTS.each do |c|
      str = str.gsub(c[0], c[1])
    end
    str
  end

end

String.send :include, StringExtensions
