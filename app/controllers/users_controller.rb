class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
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

  private

  def user_params
    params.expect(user: [:username, :firstname, :lastname, :email, :password, :password_confirmation])
  end
end
