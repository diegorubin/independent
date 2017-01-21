require 'cucumber/rails'

# Capybara.default_driver = :selenium
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :firefox)
# end
#
# Capybara.javascript_driver = :selenium
# Cucumber::Rails::Database.javascript_strategy = :truncation

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation

