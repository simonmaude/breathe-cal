Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to access more granular allergen data, 
  I should be able to view markers placed by others if enough users have reported the same allergen
  and I should be able to place a marker on the map that provides information about a place.
  
  Background:
  Given I am on the landing page

@javascript  
Scenario: If I click the add marker CTA and I am logged in then I should see a marker with a form.
  Given I am logged in as "james"
  Given I touch the add marker CTA
  And I click on the map
  Then I should see "Title" when it loads
  And I check "peanut"
  And I press "Submit"
  And I should see "peanut"
  And I should not see "oak"
  
  @javascript  
Scenario: If I click the add marker CTA and I am not logged in then I should be asked to log in before 
  seeing a marker with a form.
  Given I touch the add marker CTA
  When I am not logged in
  And I click on the map
  Then I should be taken to the google authentication page
  Given I log in as "james"
  Then I should see "Title" when it loads

@javascript  
Scenario: If I am logged in and enough users have placed markers in Berkeley for Bees then I should 
          see a Bees marker in Berkeley on my map.
  When I am not logged in
  And the center of the map should be approximately "Berkeley"
  And "5" users reported "Bees" in "Berkeley" 
  Then I should see "Bees"
  And I should not see "Peanut"

@javascript  
Scenario: If I am logged in and enough users have placed markers in Berkeley for Bees then I should 
          see a Bees marker in Berkeley on my map.
  Given I am logged in as "james"
  And the center of the map should be approximately "Berkeley"
  And "5" users reported "Bees" in "Berkeley" 
  Then I should see "Bees"
  And I should not see "Peanut"
  
  @javascript  
Scenario: If I am logged in and only 3 users have placed markers in Berkeley for Bees then I should 
          not see a Bees marker in Berkeley on my map.
  Given I am logged in as "james"
  And the center of the map should be approximately "Berkeley"
  And "3" users reported "Bees" in "Berkeley"
  Then I should not see "Bees"
  And I should not see "Peanut"
  