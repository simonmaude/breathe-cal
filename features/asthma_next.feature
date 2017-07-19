Feature: Add an option/feature to tailor the map to individuals that have 
  asthma and want to see clean air locations

  As person with asthma
  So that I can avoid polluted areas
  I want to know when there are reports of my cleaner air and polluted air

Scenario: User wants to see and select the asthma option from the pop up box in Berkeley
  Given I am on the landing page
    And my location is set to "Berkeley"
    # When I press "add alergen button" 
    # When I check "Asthma?"
    # Then I should see clean air and polluted air zones

Scenario: User wants to see polluted areas near San Jose when hes logged in
  Given I am on the landing page
  Given I am logged in as "James Jones"
  And my location is set to "San Jose"
  # When I press "add alergen button"
  # When I click "Asthma?"
  # Then I should see clean air and polluted air zones
 

Scenario: User unchecks asthma and checks allergen to see cats nearby
  Given I am on the landing page
  # And I check "Asthma?"
  # And I check "allergic_to_cats"
  # And I uncheck "Asthma?"
  # Then I should not see clean air and polluted air zones
  # And I should see nearby cat allergens

Scenario: User searches a city 
  Given I am on the landing page
  # And I search a city
  # And I scroll down the side bar
  # Then I should see clean air button/tab
  # When I click clean air button/tab
  # I should see ...? Not sure yet. ASK TROY 

Scenario: User searches a city and wants to see shaded areas for air quality
  Given I am on the landing page
  Given I am logged in as "James Jones"
  #When I search for "San Jose"
  #I should see clean air quality button/tab
  #When I click clean air button/tab
  #When I check air quality map 
  #I should see shaded regions for air quality in "San Jose"
