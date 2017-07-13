# Feature: Add alert when severe (3+ reports) level of allergen through a pop-up 

#   As person with allergies
#   So that I can avoid allergens
#   I want to know when there are reports of my allergen

# Background: Allergens will be listed globally when not logged in. 
# When logged in, allergen popups will only be triggered for cities visited.
# All popups will appear on the same location.
# When multiple popups will appear, only one will appear at a time -- the first
# will be in alphabetical order, and others will only appear when the first 
# is closed.

# Scenario: There are 3 reportings of cats in San Jose and I am not logged in 
#   When I am not logged in
#   And cats is inputted to San Jose 3 times
#   Then I should not see "Warning: Large amounts of cats in San Jose."
  
# Scenario: There are 3 reportings of cats in San Jose and I am not logged in 
#   When I am not logged in
#   And cats is inputted to San Jose 3 times
#   Then I should see "Warning: Large amounts of cats in San Jose."
#   When I press "close_popup"
#   Then I should not see "Warning: Large amounts of cats in San Jose."

# Scenario: There are 3 reportings of cats in San Jose and I am not logged in and
# I uncheck "allergic_to_cats"
#   When I am not logged in
#   And cats is inputted to San Jose 3 times
#   And I uncheck "allergic_to_cats"
#   Then I should not see "Warning: Large amounts of cats in San Jose."
  
# Scenario: There are 2 reportings of cats in San Jose and 2 reportings 
# of cats in Berkeley
#   When I am not logged in
#   And I am allergic to cats
#   And I am allergic to oak
#   And cats is inputted to Berkeley 2 times
#   And cats is inputted to San Jose 2 times
#   And my favorite cities are San Jose and Berkeley
#   Then I should not see "Warning: Large amounts of cats in San Jose"
#   And I should not see "Warning: Large amounts of cats in Berkeley"

# Scenario: There are three reportings of cats in Berkeley and I am logged in
#   When I am logged in
#   And I am allergic to cats
#   And I am allergic to oak
#   And my favorite cities are San Jose and Berkeley
#   And cats is inputted to Berkeley 3 times 
#   Then I should see "Warning: Large amounts of cats in Berkeley"

# Scenario: There are three reportings of cats and three reportings of oak in Berkeley and I am 
# logged in
#   When I am logged in
#   And I am allergic to cats and oak
#   And cats is inputted to Berkeley 3 times
#   And oak is inputted to Berkeley 3 times
#   Then I should see "Warning: Large amounts of cats in Berkeley"
#   And I should not see "Warning: Large amounts of oak in Berkeley"
#   When I press "close_popup"
#   Then I should see "Warning: Large amounts of oak in Berkeley"
#   And I should not see "Warning: Large amounts of oak in Berkeley"
#   And I should not see "Warning: Large amounts of cats in Berkeley"
  
 
