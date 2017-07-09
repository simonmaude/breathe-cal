
When(/I am (not)? logged in (as)? (user)?/) do |logged_in, as, user |
  # Does nothing when not logged in
  # Otherwise, logs in as specifies user
  pending
end
  
And /((*.) is inputted to (*.) (*.) times)/
  # Specifies what allergy is inputted to what city
  # however many number of times
  pending
end

Then /I should (not)? see (*.)/
  # Dictates whether something should be displayed
  pending
end


And /I am allergic to (*.) (and (*.))?/ do |allergens*|
 # For specified user, add specifies allergens to user
 pending
end

When /I press (*.)/
 # Just click on the button
 # Web steps takes care of this already, I think
 pending
end

