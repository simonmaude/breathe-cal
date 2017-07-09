Feature: crowd sourcing 
  As an allergy sufferer with a user account
  in order to provide other sufferers with more granular allergen data, 
  I should be able to place a marker on the map that provides information about a place.

Background:
  Given I am on the landing page

@javascript  
Scenario: If I click the add marker CTA and I am logged in then i should see a marker with a form.
  Given I am logged in as "james"
  Given I touch the add marker CTA
  And I click on the map
  Then I should see "Title" when it loads
  And I check "peanut"
  And I press "Submit"
  And I should see "peanut"
  And I should not see "oak"