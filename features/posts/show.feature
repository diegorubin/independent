Feature: Show blog post

Scenario: Show main post data
  Given that exists the post "simple_post"
  When I open blog post "simple-post"
  Then I should view "Simple post" as title
  And I should view body post
  And I should view author name and link
  And I should view post tags and links
  And I should view post category and link
  And I should view date of publish with link to list date

