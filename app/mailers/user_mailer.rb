class UserMailer < ApplicationMailer

  default from: ENV['MAILGUN_USER_NAME']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.daily_digest.subject
  #
  def daily_digest(user, alert)
    @alert = alert 
    @user = user

   
    attachments.inline["email_borderup.png"] =  
    File.read("#{Rails.root}/app/assets/images/email_borderup.png")

    attachments.inline["bcba_logo.png"] = 
    File.read("#{Rails.root}/app/assets/images/bcba_logo.png")
 
    mail to: @user.email, subject: "Daily Digest"
  end
  
  def email_alert(user, alert)
    @user = user
    @alert = alert
    
    attachments.inline["bcba_logo.png"] = 
    File.read("#{Rails.root}/app/assets/images/bcba_logo.png")
      
    attachments.inline["email_borderup.png"] =  
    File.read("#{Rails.root}/app/assets/images/email_borderup.png")
    
    mail to: @user.email, subject: "Emergency Air Alert"
  end
end
