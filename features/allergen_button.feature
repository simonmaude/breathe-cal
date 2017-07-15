Feature: The add allergen button is moved 
    As an user of this app
    So that I can search for locations, and add allergens easily
    I want to have the add allergen button inside the bar on the left side and have a search option inside the map

 Background:
  Given I am on the landing page

Scenario: Check to see the allergen button is on the bar
    Then I should see "Add Allergen" 
    

Scenario: Check to see the search box is placed on the map
    Then I should see "Search"

@javascript
Scenario: Check to see the subitems are placed in the information bar
    # I should be able to add an allergen to the map 
    Given I am logged in as "james"
    When I press add allergen button
    And I click on the map
    Then I should see "Title" when it loads
    

