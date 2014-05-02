module I18NExtensions

  def t(options = {})
    I18n.t self, options
  end

end

Symbol.send(:include, I18NExtensions)

