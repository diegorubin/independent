# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'database_cleaner'

require 'coveralls'
Coveralls.wear!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Mongoid.logger = nil

RSpec.configure do |config|
  config.mock_with :rspec

  config.include Devise::TestHelpers, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"

  end

  config.before(:each) do
    DatabaseCleaner.clean
    allow(Theme).to receive_message_chain(:path).and_return(Rails.root.join('tmp'))
  end

end

