Given(/the following clients exist/) do |clients_table|
  clients_table.hashes.each do |client|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Client.create!(client)
  end
  # fail "Unimplemented"
end

Given(/I as "(.*)" have searched for "(.*)"$/) do |client, city|
    #we will implement this model method later
    Client.addToClient(client, city)
end

And(/I should see "(.*)" above "(.*)"$/) do |city1, city2|
  #  ensure that that city1 occurs before city2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
  expect page.body.match("^.*#{city1}.*#{city2}")
end

Then(/I should see an empty search history/) do
    pending
end 

Then(/I should be at the user homepage/) do
  assert page.current_path == "http://www.breathebayarea.org/"
end


Then(/I should be taken to the google authentication page/) do 
  if page.respond_to? :should
    page.should have_content("to continue to")
  else
    assert page.has_content?("to continue to")
  end
end

Given(/I am on the sign_in page/) do
  step %{"I should be taken to the google authentication page"}
end 

Given(/I am on the sign_up page/) do
  pending
end 

Then(/^(?:|I )should see the button "([^"]*)"$/) do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then(/^(?:|I )should see the link "([^"]*)"$/) do |link|
  find_link(link).visible?
end

When(/I press the user icon/) do 
  find("#profile-icon").click
end

# When(/^(?:|I )press the icon "([^"]*)"$/) do |icon|
#   # pending
#   find(icon).click
# end

When(/^(?:|I )press the icon "([^"]*)"$/) do |icon|
  find(:xpath, "//img[contains(@src, \"#{icon.split('-')[0]}\")]").click
end

Given(/^(?:|I )successfully authenticated with Google as "([^"]*)"$/) do |name|
  visit auth_test_path(:name => name, :uid => "101010101010101", :test_check => true)
end

Given(/^(?:|I )am logged in as "([^"]*)"$/) do |name|
  visit auth_test_path(:name => name, :uid => "101010101010101",  :test_check => true)
end 

When /I am not logged in/ do 
  # Does nothing when not logged in
  # Otherwise, logs in as generic user
  unless (step %{I should see the text on the side "Sign in"})
    step %{I follow "Sign out"}
  end
  step %{I should see the text on the side "Sign in"}
end
