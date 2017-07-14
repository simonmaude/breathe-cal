Feature: Locations 
    As an allergy sufferer
    in order to look for allergens for a location,
    I need to be able to see nearby locations, 
    search for a location, and add locations as favorites. 

@javascript
Scenario: Searching for a location  
    Given I am on the landing page
    And the map has been loaded
    And my location is set to "Berkeley"
    Then the center of the map should be approximately "Berkeley"
    And the center of the map should not be approximately "Chicago"
