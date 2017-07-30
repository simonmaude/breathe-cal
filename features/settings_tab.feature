Feature: Settings Tab
  As a user, I want to be able to access a settings tab, 
  so that I can toggle notifications, access email preferences 
  and location preferences.
  
  Background:
  Given I am on the landing page  
  
Scenario: Settings button appears
  Then I should see the button "Sign in"
 
Scenario: User is logged in and clicks settings 
  Given I successfully authenticated with Google as "James Jones"
  Then I should be on the landing page
  When I press the user icon
  Then I should see "Friends"
  And I should see "Email preferences"
  And I should see "Sign Out"
  
Scenario: User is not logged in and clicks settings
  And I am not logged in
  Then I should not see "Friends"
  And I should not see "Email preferences"
  And I should not see "Sign Out"
  
Scenario: User is in settings and clicks notifications
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
	When I press "Email preferences"
  Then I should see "Receive Daily Briefing Emails"
  And I should see "Receive Emergency Alerts"
  
Scenario: User disables emergency notifications
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
	When I press "Email preferences"
  When I check "Receive Emergency Alerts"
  Then I should see "Emergency Alerts will not be sent"

Scenario: User changes email preferences
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
  When I follow "Email Preferences"
  Then I should see "Set Email Address"
  When I fill in "email" with "johnDoe@example.com"
  And I press "save"
  Then I should see "email updated"
  

Scenario: User deletes email preferences
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
  When I follow "Email Preferences"
  And I should see "Remove Email Address"
  When I fill in "email" with "johnDoe@example.com"
  And I press "save"
  Then I should see "email updated"
  When I press "delete"
  Then I should see "email deleted"
  

Scenario: User changes location preferences
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
  When I follow "Location Preferences"
  Then I should see "Set Default Location"
  When I fill in "location" with "Oakland, CA"
  And I press "save"
  Then I should see "location updated"
 

  
 
  
 
  
  
