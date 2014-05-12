RSpec.configure do |config|
  config.include Mongoid::Matchers
end

def clear_settings
  Setting.destroy_all
end

def clear_pages
  Page.destroy_all
end

