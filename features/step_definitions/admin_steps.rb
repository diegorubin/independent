Given(/^feature "([^"]*)" is "([^"]*)"$/) do |feature, value|
  FactoryGirl.create(:feature_comments, value: value)
end

