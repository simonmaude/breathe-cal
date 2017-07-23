Feature: As a user, I want to be able to filter markers on the map with checkboxes, so that I can 
  show the allergen alerts I care the most about (for example, filter markers to show presence of only mold, or only animals, etc).

Scenario: User should be able to see the checkboxes for filtering markers
  Given I am on the landing page
  # Then I should see "Cats" checkbox
  # Then I should see "Bees" checkbox
  # Then I should see "Perfume" checkbox
  # Then I should see "Oak" checkbox
  # Then I should see "Peanut" checkbox
  # Then I should see "Gluten" checkbox
  # Then I should see "Dogs" checkbox
  # Then I should see "Dust" checkbox
  # Then I should see "Smoke" checkbox
  # Then I should see "Mold" checkbox

Scenario: User should be able to see the filter button for filtering markers
  Given I am on the landing page
  # Then I should see "Filter"
  
Scenario: User enters a page with markers and filters it
  Given I am on the landing page
  Given I go to a page with marker allergens "Oak" and "Peanuts"
  Given I check checkbox "Oak"
  Then I should see only "Oak" allergen markers
  