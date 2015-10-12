# encoding: UTF-8

namespace :setup do

  desc 'Install Settings'
  task :settings => :environment do
    global = {
      :system => ['current_theme', 'meta_description', 'meta_author', 'blog_title', 'analytics_code']
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

    # load spellchecker
    r = Redis.get_connection
    r.del "words"
    File.open(File.join(Rails.root.to_s, 'db/words/pt_BR.wl')).entries.each do |word|
      r.rpush "words", word.chop.gsub(/\/.*/,'')
    end
  end

end

