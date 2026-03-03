class OrganizationsController < ApplicationController
  before_action :authenticate_user, only: %i[show]
  def index
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user = current_user
    if @organization.save
      redirect_to @organization, notice: "Successful request"
    else
      render :new
    end
  end

  def edit
  end

  def show
    @organization = Organization.find(params[:id])
    @property = @organization.properties
  end

  private

  def authenticate_user
    @organization = Organization.find(params[:id])
    unless @organization.owner?(current_user) || @organization.users.exists?(current_user.id)

    redirect_to dashboard_path
    end
  end

  def organization_params
    params.expect(organization: [:name, :email])
  end
end
