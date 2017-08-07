class UserMailer < ApplicationMailer

  default from: ENV['MAILGUN_USER_NAME']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.daily_digest.subject
  #
  def send_email(user, alert, template_name)
    @alert = alert 
    @user = user
   
   render_name = :error
   email_subject = :error
   
    case template_name
    when :daily_digest
     render_name = 'daily_digest.html.erb'
     email_subject = 'Daily Digest'
    when :email_alert 
      render_name =  'email_alert.html.erb'
      email_subject = 'Air Quality Alert'
    else
      render_name = 'error.html.erb'
      email_subject = 'Error Email'
    end
    
    attachments.inline["email_borderup.png"] =  
    File.read("#{Rails.root}/app/assets/images/email_borderup.png")

    attachments.inline["bcba_logo.png"] = 
    File.read("#{Rails.root}/app/assets/images/bcba_logo.png")
 
    
    mail to: @user.email, subject: email_subject, template_name: render_name 
  end
end
