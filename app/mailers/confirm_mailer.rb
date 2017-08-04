class ConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirm_mailer.confirm_email.subject
  #
  
  
  
  
  def confirm_email(user_email)
    @user_email = user_email
    mail to: user_email, subject: "Please Confirm Your Email", template_name: 'confirm_email.html.erb'
  end
  
  
end
