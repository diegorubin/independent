Given(/^that exists the post "([^"]*)"$/) do |factory_name|
  FactoryGirl.create(:simple_post)
end

When(/^I open blog post "([^"]*)"$/) do |slug|
  post = Post.find_by(slug: slug)
  path = Rails.application.routes.url_helpers.
    post_path(post.date, post.slug).gsub('%2F', '/')

  visit(path)
end

Then(/^I should view "([^"]*)" as title$/) do |title|
  expect(page).to have_content title
end
