Feature: Locations Details 
      As an allergy sufferer, i want to know more information about
      the allergen and what each level actually stands for.    
      
Background:

@javascript
Scenario: When I click on allergens it expands to give my a more detailed look per allergen
    Given I am on the landing page
    And my location is set to "Berkeley, CA United States"
    Then pending holder # until we implement
    When I press on the text "Allergens"
    Then I should see the text "Grass"
    And  I should see the text "Mold"
    And  I should see the text "Ragweed"
    And  I should see the text "Tree"
    And  I should see the text "UVIndex"

@javascript
Scenario: When I click on air quality I should see a more detailed view of various air quality measures

    Given I am on the landing page
    And my location is set to "Berkeley, CA United States"
    Then pending holder # until we implement
    When I press on the text "Air"
    Then I should see the text "Quality"
    And  I should see the text "Wind"
    And  I should see the text "Precip"

@javascript
Scenario: When I click on Asthma I should see a more detailed view of various air quality measures

    Given I am on the landing page
    And my location is set to "Berkeley, CA United States"
    Then pending holder # until we implement
    When I press on the text "Ashtma"

  @javascript
Scenario: I should be able to click on an allergen and key main points about allergen
    Given I am on the landing page
    And my location is set to "Berkeley"	
    # line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
# 	And I press on the text "Grass"
# 	Then I should see "What it is"
# 	Then I should see "What to watch out for"
# 	Then I should see "What to do"

@javascript
Scenario: I should be able to click on an allergen and see more information about Grass
    Given I am on the landing page
    And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
# 	And I press on the text "Grass"
# 	Then I should see "Grass produces pollen that affects outdoor allergies. It’s also easily brought indoors by wind, people and pets."
# 	And I should not see "Ragweed is a member of the daisy family with tiny yellow-green flowers that produce vast amounts of pollen – about a "
	
@javascript
Scenario: I should be able to click on an allergen and go to a different page and not see the details
    Given I am on the landing page
    And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
# 	Then I press on the text "Grass"
# 	And my location is set to "Fremont"
# 	And I should not see "Grass produces pollen that affects outdoor allergies. It’s also easily brought indoors by wind, people and pets."

  
@javascript
Scenario: I should be able to click on an allergen and see more information about Grass
    Given I am on the landing page
    And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
# 	And I press on the text "Tree"
# 	Then I should see "Trees produce light, dry pollen that can be carried by the wind for miles – one of the many reasons why they wreak havoc on your allergies."
	
@javascript
Scenario: I should be able to click on a weather and see more details
    Given I am on the landing page
    And my location is set to "Berkeley"
	# line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
# 	And I press on the text "Wind"
# 	Then I should see "Wind blows pollen into the air, causing hay fever. If you have pollen allergies, shut the windows and stay indoors on windy days."
  
@javascript
Scenario: I should be able to see where the data is taken from. 
    Given I am on the landing page
    Then I should not see "Data from AccuWeather"
	# line below is a pending holder till the info bar is implemented 
# 	Then pending holder
	
#     And my location is set to "Berkeley"
# 	Then I should see "Data from AccuWeather"


  
  