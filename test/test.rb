#!/usr/bin/env ruby
require 'nokogiri'
require 'rio'

=begin
@pre Webpage is available, modules 'nokogiri' and 'rio are loaded
@return Alert status webpage is available and alert is not "No Alert" 
or nil otherwise 
=end

def alert_status
# Save the RSS webpage to 'alerts.html' 
# (The RSS feed is improperly formatted as of July 12, 2017
# So stuff like Feedjira did not work
rio('http://www.baaqmd.gov/Feeds/AlertRSS.aspx') > rio('alerts.html')

# begin rescue block (maybe webpage unavailable)
    begin
# Open the html file
file = File.open('alerts.html')
# Only accept the html data with Nokogiri
html = Nokogiri::HTML(file)
# Get the alert status and title using the propery xpath
alert_status = html.xpath('//item/description').text
alert_title = html.xpath('//item/title').text
if alert_status != "No Alert"
    return alert_status
end

    # if no alert or webpage error, just return nothing
rescue
    return nil
end

end

alert_status
