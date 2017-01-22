Given(/^that exists the post "([^"]*)"$/) do |factory_name|
  @resource = FactoryGirl.create(:simple_post)
end

When(/^I open blog post "([^"]*)"$/) do |slug|
  @path = Rails.application.routes.url_helpers.
    post_path(@resource.date, @resource.slug).gsub('%2F', '/')

  visit(@path)
end

Then(/^I should view body post$/) do
  expect(page).to have_content @resource.body
end

