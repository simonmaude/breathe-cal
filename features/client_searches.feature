Feature: client searches 
  As an allergy sufferer with a user account
  in order to know what cities I have recently searched for, 
  I should see the last 5 cities I searched for at the bottom of the sidebar on the landing page.

Background: 
  Given I am on the landing page

@javascript   
Scenario: I should see a blank search history before having searched for anything
    Then I should see "Recent Searches"

@javascript   
Scenario: Having searched for a city I should see it displayed on the page
    Given my location is set to "Berkeley"
    And I follow "Recent Searches" 
    # Then I should see the text on the side "Berkeley"
    # And I should not see "Vancouver"
    # And I should not see "Boston"

@javascript   
Scenario: Having searched for two cities I should see the most recent one on top
    Given my location is set to "Berkeley"
    And I follow "Recent Searches"
    # And my location is set to "Albany"
    # And I follow "Recent Searches"
    # Then I should see the text on the side "Berkeley"
    # Then I should see the text on the side "Albany"
    # And I should see "Berkeley" above "Albany"    

@javascript   
Scenario: Having searched for more than 5 cities I should only see the last 5 ones displayed
    Given my location is set to "Berkeley"
    Then my location is set to "Albany"
    Then my location is set to "Oakland"
    Then my location is set to "Richmond"
    Then my location is set to "San Francisco"
    Then my location is set to "San Jose"
    And I follow "Recent Searches"
#     Then I should see "San Jose"
#     And I should see "San Francisco"
#     And I should see "Richmond"
#     And I should see "Oakland"
#     And I should see "Albany"
    # And I should not see "Berkeley"

