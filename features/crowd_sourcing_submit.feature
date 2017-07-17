Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to provide access to more granular allergen data, 
  I should be able to place a marker on the map that provides information about a place.
  
  Background:
  Given I am on the landing page
  And I am not logged in

@javascript  
Scenario: If I click the add allergen button and I am logged in then I should see a marker with a form.
  Given I am logged in as "james"
  Given I press add allergen button
  And I click on the map
  Then I should see "Title" when it loads
  And I check "peanut"
  And I press "Submit"
  And I should see "peanut"
  And I should not see "oak"
  
  @javascript  
Scenario: If I click the add marker CTA and I am not logged in then I should be asked to log in before 
  seeing a marker with a form.
  Given I press add allergen button
      # line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
  # Then I should be taken to the google authentication page
  # Given I am logged in as "james"

