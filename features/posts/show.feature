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

Scenario: Not show comment form if comment feature disabled
  Given that exists the post "simple_post"
  And feature "comment" is "disabled"
  When I open blog post "simple-post"
  Then I should not see the comment form

Scenario: Show comment form
  Given that exists the post "simple_post"
  And feature "comment" is "enabled"
  When I open blog post "simple-post"
  Then I should see the comment form

Scenario: Create comment for post
  Given that exists the post "simple_post"
  And feature "comment" is "enabled"
  When I open blog post "simple-post"
  And I put "Commenter" in name field in comment form
  And I put "comment@email.com" in email field in comment form
  And I put "http://site.com" in site field in comment form
  And I write "a simple message" in message field in comment form
  And I click in button to save comment
  Then I should see comment successful created 

Scenario: Not create invalid comment for post
  Given that exists the post "simple_post"
  And feature "comment" is "enabled"
  When I open blog post "simple-post"
  And I put "Commenter" in name field in comment form
  And I put "comment@" in email field in comment form
  And I click in button to save comment
  Then I should see the comment form

