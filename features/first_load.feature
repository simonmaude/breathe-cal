Feature: First Load
     As an allergy sufferer
     So that I can see all the information related to me
     I should be able to see my current location on the map when I first log in


Scenario: I should be able to open the app and see my location
    Given I am on the landing page
    And my current location is "Los Angeles"
	Then I should see a map
	And "Los Angeles" should be inside the map
	And "Berkeley" should not be inside the map
	
	
Scenario: I should see a populated bar on the side related to me
    Given I am on the landing page
    And my current location is "Los Angeles"
    Then I should see a populated bar
    And the side bar city has to be near "Los Angeles"


Scenario: If I cahnge cities, the side bar should change
    Given I am on the landing page
    And I searched city: "Berkeley"
    Then the side bar city should be near: "Berkeley"
    And the side bar city should not be near "Los Angeles"
