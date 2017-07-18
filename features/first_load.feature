Feature: First Load
     As an allergy sufferer
     So that I can see all the information related to me
     I should be able to see my current location on the map when I first log in


@javascript
Scenario: I should be able to open the page on a desktop understand the purpose of the page 
    Given I am on the landing page
	Then I should see a map
	And my current location has to be inside the map
    And I should see a populated bar
    And the side bar city has to be near me



