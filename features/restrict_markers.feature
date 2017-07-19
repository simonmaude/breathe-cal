Feature: Restrict number of markers in the same area
     As an allergy sufferer
     So that I can see a clear picture of the allergens 
     I should not be able to add more than 1 marker in the same area

Scenario: I should be able to add a marker
    Given I am on the landing page
    Then I should be able to add a marker

Scenario: I should not be able to more than one marker in the same area
    Given I am on the landing page
	And I have added a marker
	Then I should not be able to add another marker in the same area
    And I should be able to add a marker to another location




