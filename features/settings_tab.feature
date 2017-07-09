Feature: Settings Tab
  As a user, I want to be able to access a settings tab, 
  so that I can toggle notifications, access email preferences 
  and location preferences.
  
Scenario: Settings button appears
  Given I am on the landing page
  Then I should see the button "Settings"
 
Scenario: User is logged in and clicks settings 
  Given I successfully authenticated with Google as "James Jones"
  Then I should be on the landing page
  And I should see the button "Settings"
  When I press "Settings"
  Then I should see the button "Notifications"
  And I should see the button "Location"
  And I should see the button "Email Preferences"
  And I should see the button "Sign Out"
  
Scenario: User is not logged in and clicks settings 
  Given I am on the landing page
  When I press "Settings"
  Then I should see the button "Notifications"
  And I should see the button "Location"
  And I should see the button "Sign In"
  
Scenario: User is in settings and clicks notifications
  Given I am on the landing page
  When I press "Settings"
  When I press "Notifications"
  Then I should see "Receive Emergency Alerts"
  
Scenario: User disables emergency notifications
  Given I am on the landing page
  When I press "Settings"
  When I press "Notifications"
  When I check "Receive Emergency Alerts"
  #then i should not receive alerts (cookie)

Scenario: User changes email preferences
  Given I successfully authenticated with Google as "James Jones"
  When I press "Settings"
  When I press "Email Preferences"
  Then I should see "Change Email"
  And I should see "Do not receive Email"
  
 

  
 
  
 
  
  
