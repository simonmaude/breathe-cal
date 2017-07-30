Feature: authentication
    As an allergy sufferer
    in order to personalize my experience with the application, 
    I should be able to create/sign-in to my personal account
    
  Background:
  Given I am on the landing page

@javascript
Scenario: I should see sign-in button on the landing page
  Given I am not logged in
  Then I should see the text on the side "Sign in"
  
@javascript
Scenario: If I click on the sign-in button I should  
  Given I am not logged in
  When I follow "Sign in"
  Then I should be at the web address "accounts.google.com"

@javascript
Scenario: If I input legitimate google credentials I should be taken to the homepage as a user
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
  Then I should see the text on the side "James Jones"
  And I should not see "Some Guy"
  And I should see the text on the side "Sign Out"

@javascript
Scenario: As a logged in user I should be able to logout when I press the sign out link
  Given I successfully authenticated with Google as "James Jones"
  Then I should be on the landing page
  When I press the user icon
  Then I should see the text on the side "Sign Out"
  
  Then pending holder 
  
  When I follow "Sign Out"
  And I should not see "James Jones"
  And I should see the text on the side "Sign in"
  
