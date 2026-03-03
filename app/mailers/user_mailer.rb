class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_verification.subject
  #
  def email_verification(user)
    @user = user
    @verification_url = verify_email_url(token: @user.verification_token)
    mail(to: @user.email, subject: "Verify your email address")
  end
end
