Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to access more granular allergen data, 
  I should be able to view markers placed by others if enough users have reported the same allergen.
  
  Background:
  Given I am on the landing page
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
  
  
  @javascript  
Scenario: If I am logged in and only 3 users have placed markers in Berkeley for Bees then I should 
          not see a Bees marker in Berkeley on my map.
         
  Given I successfully authenticated with Google as "Baloo Bear"
  And the center of the map should be approximately "Berkeley"
  Then I should not see "Bees" 
  
  
     @javascript  
Scenario: If 5 users have placed markers in Berkeley for Bees and I click the add 
          marker CTA to add Bees then I should see Bees appear as a global marker in Berkeley on my map.
 
    # line below is a pending holder till the info bar is implemented 
	Then pending holder
  
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
  And I successfully authenticated with Google as "Fozzie Bear"
  
  Then I should see "bees"
  
@javascript  
Scenario: If 5 users have placed markers in Berkeley for Bees then the area around the markers should 
  become shaded.
  
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
  And I successfully authenticated with Google as "Fozzie Bear"
   
    # line below is a pending holder till shading implemented 
	Then pending holder
	
	
  Then the area around the marker "bees" should appear shaded
 