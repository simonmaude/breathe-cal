Feature: As a user, I want to be able to add my location and have it remembered, 
  so that I can see relevant data (air quality, allergens, etc.) about my city.
  
Scenario: User should be able to see the add city button
  Given I am on the landing page
  Given I fill in "pac-input" with "Piedmont, CA"
  # Then I should see "add as a favorite city"
  
Scenario: User enters a new city and adds it
  Given I am on the landing page
  Given I fill in "pac-input" with "Berkeley"
  Then I should see "Berkeley"
  
Scenario: Logged in user enters a new city logs out then logs back in
  Given I successfully authenticated with Google as "Oski Bear"
  When I fill in "pac-input" with "Berkeley"
  When I follow "Sign Out"
  When I successfully authenticated with Google as "Oski Bear"
  Then I should see "Berkeley"
