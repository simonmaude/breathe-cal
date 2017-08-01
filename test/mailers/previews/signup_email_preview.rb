# Preview all emails at http://localhost:3000/rails/mailers/example_mailer

class UserMailer < ActionMailer::Preview
  def signup_email_preview 
    UserMailer.signup_email(User.first)
  end
end