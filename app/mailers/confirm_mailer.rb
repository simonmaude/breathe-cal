class ConfirmMailer < ApplicationMailer

  
  def confirm_email(name, user_email)
    @user_email = user_email
    @user_name = name
    mail to: user_email, subject: "Please Confirm Your Email", template_name: 'confirm_email.html.erb'
  end
  
  
end
