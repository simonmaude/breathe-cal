require 'timeout'
require 'open-uri'
require 'nokogiri'
class EmailManager < ActiveRecord::Base
 
 @@alert = 'No Alert'
 
 @@previous_alert = 'No Alert'
 
 # Return email status for the url below
 # May be given to break at any time
 # (Summer 2017, Feedjira did not work because of 
 # malformed RSS feed.)
 def self.new_alert_status
    #first read the website (RSS feed for air alert)
    # with maximum wait of 5 seconds
    timeout_in_seconds = '3' 
    
    # Sometimes the website is down, so prepare for timeout
    begin
    Timeout::timeout(timeout_in_seconds.to_i) do
     html = open('http://www.baaqmd.gov/Feeds/AlertRSS.aspx', 'read_timeout' => timeout_in_seconds).read
     html = Nokogiri::HTML(html)
     return html.xpath('//item/description').text
    end
     rescue Timeout::Error
    # Assume no alert if timeout
     return "No Alert"
    end 
     
     # Take in the data with Nokogiri to be able to use xpath

 end
 
 def self.update_alert_status
  @@previous_alert = @@alert
  @@alert = EmailManager.new_alert_status
 end
 
 # Send user a daily digest
 # Should be called from config/schedule.rb (daily at 6AM)
 # template file is in app/views/user_mailer/email_digest.html.erb
 def self.email_digest
  @@alert = new_alert_status
  Client.where(email_digest: true).each do |user|
   UserMailer.send_email(user, @@alert, :daily_digest).deliver_now
  end
 end

 # Emails every user that signed up for email alerts
 # Whenever there is an air quality alert from baaqmd
 # Should be called from config/schedule.rb (hourly)
 # template file is in app/views/user_mailer/email_digest.html.erb
 def self.email_alerts
  # Keep track of previous and current alert
     @@previous_alert = @alert
     @@alert = EmailManager.new_alert_status
     
     # Stop if status is same as previous or no alert
     if @@previous_alert == @@alert or
         new_alert_status == "No Alert"
         return
     else 
     #  Otherwise, email everyone
       Client.where(email_alerts: true).each do |user|
       UserMailer.send_email(user, @@alert, :email_alert).deliver_now
       end
     end
 end
end
 