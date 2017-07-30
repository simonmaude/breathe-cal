Feature: Translations
    As an allergy sufferer
    So that I can unserstand the content on the page
    I need to be able to select a language I want


Scenario: There should be a setting language tab
    Given I am on the landing page
    And I click on settings
    Then I should see a tab for language


Scenario: I should be able to select a language
    Given I am on the landing page
    And I click on settings
    And I click on the language tab
    Then I should be able to choose "Spanish"
 
Scenario: The page language should change
    Given I am on the language settings tab
    And I select the language "Spanish"
    And I press "Submit"
    Then I should be on the landing page
    And I should see "Bienvenido"
    And I should not see "Welmcome"
    
    


