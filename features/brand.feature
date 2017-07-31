Feature: Locations Details 
       As an allergy sufferer, i want to notice the branding
       for Breathe for California for the Bay Area 
      
Background: 
  Given I am on the landing page

@javascript
Scenario: I should be able to see the lung logo when searching for a city's allergn 
    Given I should see an icon "breathe"
    And my location is set to "Berkeley"
	And I should see an icon "breathe"
	
# @javascript
# Scenario: I should notice the breathe for bay area more noticable. 
#     Given I should see an icon "bcal" 
#     When I press the icon "bcal"
#     And I should be at the web address "www.breathebayarea.org"
	
@javascript
Scenario: I should be able to access the client homepage by clicking the Breathe logos. 
    Given I should see an icon "breathe"
    
    Then pending holder
    
    When I press the icon "breathe" 
    And I should be at the web address "www.breathebayarea.org"
	

