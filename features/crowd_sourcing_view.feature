Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to access more granular allergen data, 
  I should be able to view markers placed by others if enough users have reported the same allergen.
  
  Background:
  Given I am on the landing page

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
  