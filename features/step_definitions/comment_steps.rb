Given(/^this resource have a comment$/) do
  @comment = FactoryGirl.build(:comment_published)
  @resource.comments << @comment
  @resource.save
end

When(/^I put "([^"]*)" in name field in comment form$/) do |name|
  find('input[name="comment[name]"]').set(name)
end

When(/^I put "([^"]*)" in email field in comment form$/) do |email|
  find('input[name="comment[email]"]').set(email)
end

When(/^I put "([^"]*)" in site field in comment form$/) do |site|
  find('input[name="comment[site]"]').set(site)
end

When(/^I write "([^"]*)" in message field in comment form$/) do |body|
  find('textarea[name="comment[body]"]').set(body)
end

When(/^I click in button to save comment$/) do
  find('.save-comment').click
end

Then(/^I should see comment successful created$/) do
  expect(page).to have_content(/#{:title.t(scope: [:site, :comments, :create, :success])}/i)
end

Then(/^I should see the approved comment$/) do
  expect(page).to have_content(@comment.body)

  link = find_link(@comment.name)
  expect(link[:href]).to include(@comment.site)

  formated_date = I18n.l @comment.created_at, format: :long
  expect(page).to have_content(formated_date)
end

Then(/^I should not see the comment form$/) do
  comment_path = Rails.application.routes.url_helpers.comments_path
  expect(page).to_not have_selector("form[action=\"#{comment_path}\"][method=\"post\"]")
end

Then(/^I should see the comment form$/) do
  comment_path = Rails.application.routes.url_helpers.comments_path
  expect(page).to have_selector("form[action=\"#{comment_path}\"][method=\"post\"]")
end

