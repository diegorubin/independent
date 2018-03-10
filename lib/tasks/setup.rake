# encoding: UTF-8

namespace :setup do

  desc 'Install Settings'
  task :settings => :environment do
    global = {
      :features => [
        'comments', 'multiple_domains'
      ],
      :system => [
        'current_theme', 'meta_description', 'meta_author', 
        'blog_title', 'analytics_code', 'domains'
      ]
    }
    
    default = {
      :header => ['title', 'subtitle']
    }

    global.each do |category, settings|
      settings.each do |setting|
        Setting.create(title: setting, category: category, theme: 'global')
      end
    end
    
    domain_settings = Setting.where({theme: 'global', title: 'domains'}).first
    domains = domain_settings ? domain_settings.value.split(',') : ['default']
    domains.each do |domain|
      default.each do |category, settings|
        settings.each do |setting|
          r = Setting.create(title: setting, category: category, domain: domain, theme: 'default')
        end
      end
    end
    
    # set current theme
    current_theme = Setting.where({theme: 'global', title: 'current_theme'}).first
    current_theme.update({value: 'default'})

  end

end

