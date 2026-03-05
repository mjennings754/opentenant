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
    @user = User.find(params[:id])
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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy!
      redirect_to signup_path
    else
      redirect_to @user
    end
  end

  def update
    if password_update_requested?
      update_password
    end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        redirect_to params[:return_to], notice: "Password was successfully changed"
      else
        render :edit
      end
    else
      redirect_to params[:return_to], notice: "Incorrect password"
    end
  end
  
  private

  def password_update_requested?
    params[:user][:password].present? && params[:user][:password_confirmation].present?
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.expect(user: [:username, :firstname, :lastname, :email, :password, :password_confirmation])
  end
end
