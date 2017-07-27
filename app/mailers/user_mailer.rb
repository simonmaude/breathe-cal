require 'mailgun'
class UserMailer < ApplicationMailer
  default from: 'breathcaliforniadigest@gmail.com'
  def signup_email(user)
      @user = user
      mail(to: @user.email, subject: 'Sample email')
  end
  
  # Used for testing mailgun API
  def mailgunner(user)
    @user = user
    mg_client = Mailgun::Client.new(ENV[MAILGUN_KEY])
    message_params = {:from    => "postmaster@sandbox0880c15a47cd403ea19793a12bd76d5f.mailgun.org",
                      :to      => 'albertytung@berkeley.edu',
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message("sandbox0880c15a47cd403ea19793a12bd76d5f.mailgun.org", message_params)
  end
  
  def email_alert(user, allergen_status)
    @user = user
    mail to: @user.email, subject: "Emergency Air Alert"
  end
  
  def daily_digest(user)
    @user = user
    mail to: @user.email, subject: "Daily  Quality Digest"
  end
end
