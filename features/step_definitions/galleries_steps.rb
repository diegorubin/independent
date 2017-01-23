Given(/^that exists the gallery "([^"]*)"$/) do |factory_name|
  @resource = FactoryGirl.create(factory_name.to_sym)
end

When(/^I open blog gallery "([^"]*)"$/) do |slug|
  @path = Rails.application.routes.url_helpers.
    gallery_path(@resource.date, @resource.slug).gsub('%2F', '/')

  visit(@path)
end

Then(/^I should view first picture$/) do
  expect(page).to have_content @resource.items[0].title
  expect(page).to have_content @resource.items[0].description
end

