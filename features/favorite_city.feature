Feature: Favorite Locations 
    As an allergy sufferer
    in order to quickly look for allergen information,
    I need to be able to favorite locations,
    and access information for them by clicking on a button

#happy path, favoriting a city 
@javascript 
Scenario: Once I sign in, I should be able to favorite cities 
    Given I successfully authenticated with Google as "Anish Khazane"
    When I go to the landing page
    And my location is set to "Berkeley"
    # And I follow "add as a favorite city" 
    # Then I should see "Added Berkeley to your favorite cities!"
    
#sad path, not signed in
@javascript 
Scenario: If not signed in, I should not be able to favorite a city
    When I go to the landing page
    And my location is set to "Berkeley"
    Then I should not see "add as a favorite city"
 
#happy path, favorite and unfavorite
@javascript
Scenario: If a city is already favorited, I should be able to remove it from my list of cities
    Given I successfully authenticated with Google as "Anish Khazane"
    When I go to the landing page
    And my location is set to "Berkeley"
    # And I follow "add as a favorite city" 
    # Then I should see "Added Berkeley to your favorite cities!"
    # And I follow "remove as a favorite city"
    # Then I should see "Removed Berkeley from your favorite cities!"
    
#happy path, favorite cities list    
@javascript 
Scenario: I should be able to see a list of my favorite cities 
    Given I successfully authenticated with Google as "Anish Khazane"
    When I go to the landing page
    And my location is set to "Berkeley"
    # And I follow "Back"
    # And I follow "View Favorites"
    # Then I should see "Berkeley"
 

