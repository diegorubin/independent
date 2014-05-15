RSpec.configure do |config|
  config.include Mongoid::Matchers
end

def clear_list
  ListItem.destroy_all
end

def clear_settings
  Setting.destroy_all
end

def clear_posts
  Post.destroy_all
end

def clear_pages
  Page.destroy_all
end

def clear_presentations
  Presentation.destroy_all
end

