class ConfirmMailer < ApplicationMailer

  
  def confirm_email(name, user_id, user_email, random_number)
    @user_email = user_email
    @user_name = name
    @confirm_link = "https://work-sordem.c9users.io/email_confirm/" + user_id + "/" + random_number
    @delete_link = "https://work-sordem.c9users.io/delete_email/" + user_id + "/" + random_number
    mail to: user_email, subject: "Please Confirm Your Email", template_name: 'confirm_email.html.erb'
  end
  
end

