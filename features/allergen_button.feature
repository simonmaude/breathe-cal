Feature: The add allergen button is moved 


    As an user of this app
    So that I can search for locations, and add allergens easily
    I want to have the add allergen button inside the bar on the left side and have a search option inside the map


Scenario: Check to see the allergen button is on the bar
    Given I am on the home page of the application
    Then I should see the allergen button on the bar
    


Scenario: Check to see the search box is placed on the map
    Given I am on the home page of the application
    Then I should see the "search box" on the map


Scenario: Check to see the subitems are placed in the information bar
    Given I am on the home page of the application
    When I click the add allergen button
    Then I should be able to add an allergen to the map 
    

