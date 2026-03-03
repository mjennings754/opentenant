class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.email_verification(@user).deliver_later
      login(@user)
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def verify_email
    @user = User.find_by(verification_token: params[:token])
    if @user&.verify_email(params[:token])
      redirect_to dashboard_path, notice: "Your email has been successfully verified"
    else
      redirect_to login_path, notice: "Invalid token"
    end
  end

  def resend_verification
    if current_user&.unverified?
      UserMailer.email_verification(current_user).deliver_now
      redirect_to dashboard_path, notice: "Verification email resent"
    else
      redirect_to dashboard_path, notice: "error"
    end
  end
  
  private

  def user_params
    params.expect(user: [:username, :firstname, :lastname, :email, :password, :password_confirmation])
  end
end
