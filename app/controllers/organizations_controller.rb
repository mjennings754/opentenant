class OrganizationsController < ApplicationController
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

  def organization_params
    params.expect(organization: [:name, :email])
  end
end
