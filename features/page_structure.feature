Feature: The page is correctly structured 


    As an user of this app
    So that I feel familiar and comfortable using the application
    I want to have the information bar and options on the left side of the screen and the map on the right side



Scenario: Check to see the map is on the right side 
    Given I am on the home page of the application
    Then I should see the map on the right side
    


Scenario: Check to see the information bar is on the left
    Given I am on the home page of the application
    Then I should see the information bar on the left side
    
    

Scenario: Check to see the subitems are placed in the information bar
    Given I am on the home page of the application
    Then I should see "Recent Searches" on the bar
    And I should see "View Favorites" on the bar
    And I should see the "add allergen button" on the bar
    And I should see the "date" on the bar
    And I should see "Sign in with Google+" on the bar
    
