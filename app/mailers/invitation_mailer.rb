class InvitationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite_user.subject
  #
  def invite_user(invitation)
    @invitation = invitation
    @invitable = invitation.invitable
    @url = accept_invitation_url(token: invitation.token)
    invitable_type = @invitable.class.name
    mail(to: @invitation.email, subject: "You're invited to join #{@invitable_type}")
  end
end
