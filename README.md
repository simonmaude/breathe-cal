<a href="https://codeclimate.com/github/MaadhavShah/breathe-cal"><img src="https://codeclimate.com/github/MaadhavShah/breathe-cal/badges/gpa.svg" /></a>
<a href="https://travis-ci.org/simonmaude/breathe-cal"><img src="https://travis-ci.org/simonmaude/breathe-cal.svg?branch=master" alt="Build Status" /></a>
<a href=https://codeclimate.com/github/simonmaude/breathe-cal/coverage><img src="https://codeclimate.com/github/simonmaude/breathe-cal/badges/coverage.svg" /></a>

Our overall goal is provide individuals access to relevant allergen and air quality data so that they may be better prepared in the case of an adverse lung health event.

TravisCI Badge for master branch showing passing:


CodeClimate Badge with GPA and code coverage:


Heroku Link:
https://tranquil-wildwood-40360.herokuapp.com/
(previous group: https://afternoon-temple-78844.herokuapp.com/)

Client Site:
http://www.breathebayarea.org/

Pivotal Link:
https://www.pivotaltracker.com/n/projects/2118203
(previous group: https://www.pivotaltracker.com/projects/2070837)

Installation:
 Because of some customizations that were made in the develpoment process, one first has to perform multiple steps in order to be able to run the included testing features
 Make sure the following gems are added to the Gemfile:
     gem 'cucumber-rails', :require => false
     gem 'database_cleaner'
     gem 'rspec-rails'
     gem 'capybara'
     gem 'poltergeist'
     gem 'phantomjs', '2.1.1'
     gem 'selenium-webdriver'
     gem 'omniauth-google-oauth2'
     gem 'gmaps4rails'
     gem 'geocoder'
     
 Follow with Bundle install.
 In order to make Capybara use PhantomJS headless browser through the Poltergeist driver the code below should be added to the test setup file.:
 
 require 'capybara/poltergeist'
 
 Capybara.javascript_driver = :poltergeist
 
 Capybara.register_driver :poltergeist do |app|  
   Capybara::Poltergeist::Driver.new(app, js_error: false)
 end  
 
 
Since the app integrates Google Map API, be sure to add your development website to Google Map API 
https://console.developers.google.com/apis/credentials/oauthclient/140496364556-f0lvk46ni0jm0ke4k41nfnlp5mj7j8tl.apps.googleusercontent.com?project=breathe-149522&authuser=1

Likewise, the API key for the Accuweather 5 day forecast that is used to get weather and allergen data is set in city.rb of the model folder. The free version of this key will last 6 months, allows 500 queries a day and can be renewed or upgraded here: http://bit.ly/2uwNsb8

