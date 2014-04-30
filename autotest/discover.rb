Autotest.add_discovery { "rspec2" }
Autotest.add_hook :initialize do |at|
  # Prevent infinite loops by ignoring volatile files
  %w{.git vendordb log tmp .DS_store Gemfile.lock}.each do |exception|
    at.add_exception(exception)
  end
end

