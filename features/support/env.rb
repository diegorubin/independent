require 'cucumber/rails'

if ENV['USE_REAL_BROWSER'] == 'true'
  Capybara.default_driver = :selenium
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
  
  Capybara.javascript_driver = :selenium
  Cucumber::Rails::Database.javascript_strategy = :truncation
end

ActionController::Base.allow_rescue = false
DatabaseCleaner.strategy = :truncation

