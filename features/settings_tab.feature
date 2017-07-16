Feature: Settings Tab
  As a user, I want to be able to access a settings tab, 
  so that I can toggle notifications, access email preferences 
  and location preferences.
  
Scenario: Settings button appears
  Given I am on the landing page
  Then I should see the button "Sign in"
 
Scenario: User is logged in and clicks settings 
  Given I successfully authenticated with Google as "James Jones"
  Then I should be on the landing page
  And I should see the button "Email preferences"
  When I press the user icon
  Then I should see "Friends"
  And I should see "Email preferences"
  And I should see "Sign Out"
  
Scenario: User is not logged in and clicks settings 
  Given I am on the landing page
  And I am not logged in
  Then I should not see "Friends"
  And I should not see "Email preferences"
  And I should not see "Sign Out"
  
# Scenario: User is in settings and clicks notifications
#   Given I am on the landing page
  # When I press the user icon
  # When I press "Notifications"
  # Then I should see "Receive Emergency Alerts"
  
# Scenario: User disables emergency notifications
#   Given I am on the landing page
  # When I press the user icon
  # When I press "Notifications"
  # When I check "Receive Emergency Alerts"
  #then i should not receive alerts (cookie)

Scenario: User changes email preferences
  Given I successfully authenticated with Google as "James Jones"
  When I press the user icon
  
    # line below is a pending holder till email preferences are implemented 
	Then pending holder
  
  When I follow "Email Preferences"
  Then I should see "Change Email"
  And I should see "Do not receive Email"
  
 

  
 
  
 
  
  
