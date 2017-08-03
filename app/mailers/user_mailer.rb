class UserMailer < ApplicationMailer

  #default from: "postmaster@sandbox0880c15a47cd403ea19793a12bd76d5f.mailgun.org"
  default from: ENV['MAILGUN_USER_NAME']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.daily_digest.subject
  #
  def daily_digest
    @greeting = "Hi"

    mail to: "albertytung@berkeley.edu", subject: "Success! You did it."
  end
end
