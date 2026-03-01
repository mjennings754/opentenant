class InvitationsController < ApplicationController
  def new
    @invitable = find_invitable
    @invitation = @invitable.invitations.new
  end

  def create
    @invitable = find_invitable
    @invitation = @invitable.invitations.new(invitation_params)
    @invitation.inviter = current_user
    @invitation.invited_user = User.find_by(email: @invitation.email)

    if @invitation.save
      InvitationMailer.invite_user(@invitation).deliver_later
      redirect_to @invitation.invitable, notice: "Invitation has been sent"
    else
      render :new
    end
  end

  def accept
    @invitation = Invitation.find_by(token: params[:token])

    if @invitation.nil?
      redirect_to login_path, notice: "Invalid or expired token"
      return
    end

    invited_user = @invitation.invited_user

    if @invitation.invited_user.present? && @invitation.invited_user != current_user
      redirect_to login_path, notice: "This invitation is not for you"
      return
    end

    if user_already_member?(@invitation.invitable, current_user)
      redirect_to @invitation.invitable, notice: "You're already a member"
      return
    end

    create_invitable_member(@invitation.invitable, current_user)

    redirect_to @invitation.invitable, notice: "Invitation accepted and you are now a member"
  end

  def find_invitable
    Organization.find(params[:organization_id])
  end

  def user_already_member?(invitable, user)
    if invitable.is_a?(Organization)
      invitable.members.exists?(user_id: user.id)
    else
       false
    end
  end

  private

  def create_invitable_member(invitable, user)
    if invitable.is_a?(Organization)
      create_organization_member(invitable, user)
    end
  end
  def create_organization_member(organization, user)
    if organization.members.exists?(user_id: user.id)
      redirect_to dashboard_path, notice: "User is already apart of the organization"
    else
      organization.members.create(user: user, role: @invitation.role)
    end
  end

  def invitation_params
    params.require(:invitation).permit(:email, :role)
  end
end
