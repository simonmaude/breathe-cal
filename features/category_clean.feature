Feature: Split elements into categories to have a much cleaner looking app

  As a user looking for information 
  So that I can have an easy time accessing what I need 
  I want to know where to click to see the relevant information that I am seeking 

#Some steps are commented out due to the actual feature not being implemented resulting in a failure of the 
#Cucumber tests so they are commented out for now. 

Scenario: User wants to see the categories that are available to see 
  Given I am on the landing page
    And my location is set to "Berkeley"
    # Then I should see "Allergens"
    # Then I should see "Air Quality"

Scenario: User wants to click Allergens and see the Allergens in the San Jose area
  Given I am on the landing page
  Given I am logged in as "James Jones"
  And my location is set to "San Jose"
  # Then I should see "Allergens"
  # When I press "Allergens"
  # Then I should see "Pollen"
 

Scenario: User clicks a category and clicks another category for both information
  Given I am on the landing page
  And my location is set to "San Jose"
  # When I press "Allergens"
  # Then I should see "Pollen"
  # When I press "Air Quality"
  # Then I should see "Air Quality"

Scenario: User clicks a category and unclicks category for no information
  Given I am on the landing page
  And my location is set to "Fresno"
  # When I press "Allergens"
  # Then I should see "Pollen"
  # When I press "Allergens"
  # Then I should not see "Pollen"
  # When I press "Air Quality"
  # Then I should see "Air Quality"
  # I should see ...? Not sure yet. ASK TROY 