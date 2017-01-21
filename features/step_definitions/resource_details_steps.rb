Then(/^I should view "([^"]*)" as title$/) do |title|
  expect(page).to have_content title
end

Then(/^I should view author name and link$/) do
  link = find_link(@resource.author)
  author_link = Rails.application.routes.url_helpers.
    page_path(@resource.author)
  expect(link[:href]).to include(author_link)
end

Then(/^I should view post tags and links$/) do
  @resource.tags_list.each do |tag|
    tag_link = Rails.application.routes.url_helpers.
      tag_path(tag)
    link = find_link(tag)
    expect(link[:href]).to include(tag_link)
  end
end

Then(/^I should view post category and link$/) do
  link = find_link(@resource.category)
  category_link = Rails.application.routes.url_helpers.
    category_path(@resource.category)
  expect(link[:href]).to include(category_link)
end

Then(/^I should view date of publish with link to list date$/) do
  formated_date = I18n.l @resource.published_at, format: :long
  link = find_link(formated_date)
  date_link = Rails.application.routes.url_helpers.
    date_path(@resource.date).gsub('%2F', '/')
  expect(link[:href]).to include(date_link)
end

