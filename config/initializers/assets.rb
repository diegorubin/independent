Rails.application.config.assets.precompile += %w( 
  admin.css admin.js login.css 
  default.css default.js

  presentation.css presentation.js
  comments.js
)

Theme.all.collect do |t| 
  Rails.application.config.assets.precompile += %W(#{t.label}.js #{t.label}.css)
end

