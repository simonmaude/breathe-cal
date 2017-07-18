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
  Then I should see "Title" when it loads
  And I check "peanut"
  And I press "Submit"
  And I should see "peanut"
  
    # line below is a pending holder till the edit text input is implemented 
	Then pending holder
  
  Then I fill in "cats" with "edit_marker_text_input"
  And I press "edit"
  And I should see "cats"
  And I should not see "peanut"
  
  @javascript  
Scenario: If I click the add allergen button and I am logged in then I should be able to delete it after creating it.
  Given I am logged in as "james"
  Given I press add allergen button
  And I click on the map
  Then I should see "Title" when it loads
  And I check "peanut"
  And I press "Submit"
  And I should see "peanut"
   
    # line below is a pending holder till delete button is implemented 
	Then pending holder
	
  Then I press "delete"
  And I should not see "peanut"  
  
  @javascript  
Scenario: If I am logged out then I should not be able to delete global markers.
  Given I am logged in as "Oski Bear"
  Then I should not see "Bees" 
  Then I press add allergen button
  And I click on the map
  And I check "bees"
  And I press "Submit"
  And I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  And I successfully authenticated with Google as "Paddington Bear"
  Then I should not see "Bees" 
  Then I press add allergen button
  And I click on the map
  And I check "bees"
  And I press "Submit"
  Then I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  And I successfully authenticated with Google as "Yogi Bear"
  Then I should not see "Bees" 
  Then I press add allergen button
  And I click on the map
  And I check "bees"
  And I press "Submit"
  Then I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  And I successfully authenticated with Google as "Smokey Bear"
  Then I press add allergen button
  And I click on the map
  And I check "bees"
  And I press "Submit"
  Then I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  And I successfully authenticated with Google as "Rupert Bear"
  Then I press add allergen button
  And I click on the map
  And I check "bees"
  And I press "Submit"
  Then I should see "bees"
  Then I press the user icon
  And I follow "Sign Out"
  
    # line below is a pending holder till the delete button is implemented
	Then pending holder
  
  And I shoud see "bees"
  And I should not see "delete"
  

  
