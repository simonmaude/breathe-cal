Feature: Spare the Air Alert System  
  As an allergy sufferer 
  in order to receive emergency alert notifications for the Bay Area    
  I should see an alert box at the top of the application's home page 

@javascript   
Scenario: I should see alerts for San Francisco
    Given I am on the landing page
    Then I should see "High pollen levels in Berkeley"
    And I should not see "No Alert"