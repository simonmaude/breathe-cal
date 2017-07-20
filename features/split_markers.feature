
Feature: Split multiple assigned marker into separate markers. 
    As an allergy sufferer
    So that I can easily identify which allergens on a map.
    A marker with multiple allergens should be split up into multiple markers, each wwith a single allergens
    
Preconditions:
Smoke's is a location with the coordinates:
Latitude: 37.867672 | Longitude: -122.258142
And Smoke's currently has no allergen markers

Scenario: Place marker with single allergen  
  When I add a marker with Dogs at Smoke's
  Then I should see a marker with Dogs around Smoke's
  And I should not see a marker with Cats around Smoke's
  And I should not see a marker with Oak around Smoke's

Scenario: Place marker with two allergens
  When I add a marker with Dogs and Cats at Smoke's
  Then I should see a marker with Dogs at Smoke's
  And I should see a marker with Cats at Smoke's
  And I should not see a marker with Bees at Smoke's
  And I should not see a marker with Oak at Smoke's


Scenario: Place marker with three allergens
  When I add a marker with Dogs and Cats and Bees at Smoke's
  Then I should see a marker with Dogs at Smoke's
  And I should see a marker with Cats at Smoke's
  And I should see a marker with Bees at Smoke's
  And I should not see a marker with Oak at Smoke's
  And I should not see a marker with Peanut at Smoke's
