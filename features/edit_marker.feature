Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to provide access to more granular allergen data, 
  I should be able to edit markers on the map to update the information they provide about a place.
  
  Background:
  Given I am on the landing page

@javascript  
Scenario: If I click the add allergen button and I am logged in then I should be able to edit it after creating it.
  Given I am logged in as "james"
  Given I press add allergen button
  And I click on the map
  Then I should see "Allergen:" when it loads
  Then I fill in "title" with "peanut"
  And I should see "peanut"
  Then I press "edit"
  And I fill in "title" with "cats"
  Then I should see "cats"
  And I should not see "peanut"
  
  @javascript  
Scenario: If I click the add allergen button and I am logged in then I should be able to delete it after creating it.
  Given I am logged in as "james"
  Given I press add allergen button
  And I click on the map
  Then I should see "Allergen:" when it loads
  Then I fill in "title" with "peanut"
  And I should see "peanut"
   
    # line below is a pending holder till delete button is implemented 
	Then pending holder
	
  Then I press "delete"
  And I should not see "peanut"  
  
  @javascript  
Scenario: If I am logged out then I should not be able to delete global markers.
  Given I am logged in as "Oski Bear"
  Then I press add allergen button
  And I click on the map
  Then I should see "Allergen:" when it loads
  And I fill in "title" with "bees"
  Then I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  And I shoud see "bees"
  And I should not see "delete"
  

  
