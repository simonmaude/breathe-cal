Feature: Locations 
     As an allergy sufferer in order to know the allergen data 	
     and weather data, I should be able to clearly be able to     
     visualize the data (utilizing colors and graphs)  and be able 
     to clearly understand the information on the page.   
    
Background: 

@javascript
Scenario: I should be able to open the page on a desktop understand the purpose of the page 
    Given I am on the landing page
	Then I should see a map
	And I should see the greeting section
	And I should see the text on the side "Welcome user"
	And I should see an icon "bcal"

	
@javascript
Scenario: I should be able to see the allergn details of the page 
	When I go to the landing page
	And my location is set to "Berkeley, CA United States"
	And I should see the alert section
	# line below is a pending holder till the info bar is implemented 
	Then pending holder
	And I should see the text on the side "Berkeley Air Quality:"
    And I should see an icon "Tree"
    And I should see an icon "Grass"
    And I should see an icon "Ragweed"
    And I should see an icon "Mold"
    And I should see an icon "UVIndex"

        
@javascript     
Scenario: I should be able to see the breathing details of the page 
	When I go to the landing page
	And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
	Then pending holder
	
    And I should see an icon "precip"
    And I should see an icon "wind"
    And I should see the text on the side "Precip"
    And I should see the text on the side "Wind"
    
 
 @javascript   
Scenario: I should be able to see the other forcasts details of the page 
	Given I am on the landing page
	And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
	Then pending holder

    And I should see the text on the side "Other Forecasts"
    
 @javascript   
Scenario: I should be able to see the weather forcasts details of the page 
	Given I am on the landing page
	And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
	Then pending holder
	
 	And I should see the weather section 
	And I should see a weather icon inside
    
    
