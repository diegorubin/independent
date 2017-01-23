Given(/^that exists the presentation "([^"]*)"$/) do |factory_name|
  @resource = FactoryGirl.create(:simple_presentation)
end

When(/^I open blog presentation "([^"]*)"$/) do |slug|
  @path = Rails.application.routes.url_helpers.
    presentation_path(@resource.date, @resource.slug).gsub('%2F', '/')

  visit(@path)
end

When(/^I click in next button$/) do
  all(".nextSlide")[0].click
end

Then(/^I should view first slide$/) do
  filename = @resource.slides.first.file.filename
  style = find("#presentation")[:style]
  expect(style).to include(filename)
end

Then(/^I should see second slide$/) do
  filename = @resource.slides[1].file.filename
  style = find("#presentation")[:style]
  expect(style).to include(filename)
end

