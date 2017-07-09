Feature: Locations Details 
       As an allergy sufferer, i want to notice the branding
       for Breathe for California for the Bay Area 
      
Background: 

@javascript
Scenario: I should be able to see the lung logo when searching for a city's allergn 
    Given I am on the landing page
    Then I should see an icon "lung"
    And my location is set to "Berkeley"
	And I should see an icon "lung"
	
@javascript
Scenario: I should notice the breathe for bay area more noticable. 
    Given I am on the landing page
    Then I should see an icon "bcal" 
    And my location is set to "Berkeley"
	And I should see an icon "bcal"
	
@javascript
Scenario: I should be able to access the client homepage by clicking the lung logo. 
    Given I see an icon "lung" 
    And I press an icon "lung" 
    Then I should see "As the clean air and healthy lungs leader" when it loads
	Then I should be on the user homepage
	
