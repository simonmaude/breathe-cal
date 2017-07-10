Feature: Fix the bar on the blank box area that is empty so that it 
  has he necessary features that it once did 
  
   As an user of this app
   So that I have easy access to suggestions and preferences at a reachable location
   I want to have the information bar and options appear in a user friendly manner 


Scenario: Check to see if the bar is visisble 
  Given I am on the landing page
    And my location is set to "Berkeley"
    When I click on "add alergen button" 
    When I check "cats"
    Then I should see a populated bar

Scenario: Check to see if the bar has relevant information
  Given I am on the landing page
    And my location is set to "Berkeley"
    When I click on "add alergen button" 
    When I check "Asthma?"
    Then I should see a populated bar
     And I should see information about "Asthma" listed
 

Scenario: Check to see if the bar changes information if different settings are chosen
  Given I am on the landing page
  And I check "Asthma?"
  And I check "allergic_to_cats"
  And I uncheck "Asthma?"
  Then I should not see clean air and polluted air zones
  And I should see nearby cat allergens
  And I should see information about "cats" listed
  And I should not see information about "cats" listed