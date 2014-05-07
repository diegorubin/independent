# Primeiro usuário
User.create({
  name: 'Administrador', email: 'admin@independent.com',
  email_confirmation: 'admin@independent.com',
  password: 'removerusuario', password_confirmation: 'removerusuario'
})

# Configurações globais
global = {
  :system => ['current_theme', 'meta_description', 'meta_author', 'blog_title']
}

default = {
  :header => ['title', 'subtitle']
}

global.each do |category, settings|
  settings.each do |setting|
    Setting.create(title: setting, category: category, theme: 'global')
  end
end

default.each do |category, settings|
  settings.each do |setting|
    Setting.create(title: setting, category: category, theme: 'default')
  end
end

# set current theme
current_theme = Setting.where({theme: 'global', title: 'current_theme'}).first
current_theme.update({value: 'default'})

