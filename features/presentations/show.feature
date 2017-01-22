Feature: Show blog presentation

Scenario: Show main presentation data
  Given that exists the presentation "simple_presentation"
  When I open blog presentation "simple-presentation"
  Then I should view "Simple presentation" as title
  And I should view first slide
  And I should view author name and link
  And I should view post tags and links
  And I should view post category and link
  And I should view date of publish with link to list date

Scenario: Not show comment form if comment feature disabled
  Given that exists the presentation "simple_presentation"
  And feature "comment" is "disabled"
  When I open blog presentation "simple-presentation"
  Then I should not see the comment form

Scenario: Show comment form
  Given that exists the presentation "simple_presentation"
  And feature "comment" is "enabled"
  When I open blog presentation "simple-presentation"
  Then I should see the comment form

Scenario: Create comment for presentation
  Given that exists the presentation "simple_presentation"
  And feature "comment" is "enabled"
  When I open blog presentation "simple-presentation"
  And I put "Commenter" in name field in comment form
  And I put "comment@email.com" in email field in comment form
  And I put "http://site.com" in site field in comment form
  And I write "a simple message" in message field in comment form
  And I click in button to save comment
  Then I should see comment successful created 

Scenario: Not create invalid comment for presentation
  Given that exists the presentation "simple_presentation"
  And feature "comment" is "enabled"
  When I open blog presentation "simple-presentation"
  And I put "Commenter" in name field in comment form
  And I put "comment@" in email field in comment form
  And I click in button to save comment
  Then I should see the comment form

Scenario: Show approved comment
  Given that exists the presentation "simple_presentation"
  And this resource have a comment
  And feature "comment" is "enabled"
  When I open blog presentation "simple-presentation"
  Then I should see the approved comment

