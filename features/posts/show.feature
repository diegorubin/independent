Feature: Show blog post

Scenario: Show main post data
  Given that exists the post "simple_post"
  When I open blog post "simple-post"
  Then I should view "Simple post" as title

