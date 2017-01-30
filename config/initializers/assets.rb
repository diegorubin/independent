Rails.application.config.assets.precompile += %w( 
  admin.css admin.js login.css 
  default.css default.js

  gallery.css gallery.js

  kindle.css kindle.js

  presentation.css presentation.js
  comments.js
)

Theme.all.each do |t| 
  Rails.application.config.assets.precompile += %W(#{t.label}.js #{t.label}.css)
  Rails.application.config.assets.precompile += 
    t.files.collect{ |f| f =~ /\/(.*?(scss|js|eot|woff|woff2))$/ && $1 }.compact
end

