Feature: User profiles (a user can access a personal profile, add a picture, and other standard profile features.)
  
Scenario: User profile icon appears when not logged in
  Given I am on the landing page 
  Then I should see an icon "default_user"
  
Scenario: User profile image appears when logged in
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Then I should see an icon "user_profile_img"
  
Scenario: User should see change profile picture when logged in 
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Then I should see the button "User Profile"
  
  
Scenario: If logged in, user should see change profile picture when profile is clicked
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Given I press the button "User Profile"
  Then I should should see the button "Change Picture"
  
Scenario: User sees change porfile picture button when logged in
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Given I press the button "User Profile"
  Then I should see the button "Change Picture"
  
Scenario: User clicks on change picture when logged in
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Given I press the button "User Profile"
  When I press the button "Change Picture"
  Then I should see "Choose Photo"

Scenario: User sees add friend button 
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Given I press the button "User Profile"
  Then  I should see the button "Add Friend"
  
Scenario: User sees friends list
  Given I am on the landing page 
  Given I successfully authenticated with Google as "Oski Bear"
  Given I press the button "User Profile"
  Then  I should see "Friends"
 
  

  
  
  