require 'date'
require 'nokogiri'
require 'open-uri'
class BreatheController < ApplicationController
  def index
  # Save the RSS webpage to 'alerts.html' 
  # (The RSS feed is improperly formatted as of July 12, 2017
  # So stuff like Feedjira did not work
  
  
  # begin rescue block (maybe webpage unavailable)
  begin
  
  # first read the website (RSS feed for air alert)
    # html = open('http://www.baaqmd.gov/Feeds/AlertRSS.aspx').read

    # # Take in the data with Nokogiri to be able to use xpath
    # html = Nokogiri::HTML(html)
    # @alert = html.xpath('//item/description').text
    # @welcome_message = html.xpath('//item/title').text
    
    
      @welcome_message = "Spare the Air Day Info"
      @alert = "No Alert"
    # if no alert or webpage error, display following
    rescue
      @welcome_message = "Spare the Air Day Info"
      @alert = "Spare the Air Day info is currently unavailable"
  #end rescue block
  end
      
    if @text.nil?
      @text = "Recent Searches"
    end
    # session.clear
    # @users = User.all
    # @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    # marker.lat user.latitude
    # marker.lng user.longitude
    # end
    # @cityname = "Berkeley"
    if session[:cities]
      if session[:cities].length > 5
        session[:cities] = session[:cities][session[:cities].length - 5, session[:cities].length - 1]
      end
      @cities = session[:cities]
    else
      @cities = []
      session[:cities] = []
    end
    @cities = @cities.reverse
    
    @text = "Recent Searches"
    Time::DATE_FORMATS[:custom] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }
    @dt = (DateTime.now + Rational(-8,24)).to_formatted_s(:custom)
 end
    
end
