class PropertiesController < ApplicationController
  before_action :set_organization
  before_action :authenticate_user, only: %i[show]
  def index
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.organization = @organization
    if @property.save
      redirect_to [@organization, @property]
    else
      render :new
    end
  end


  def edit
  end

  def show
    @property = Property.find(params[:id])
  end

  private

  def authenticate_user
    @property = Property.find(params[:id])
    unless @property.users.exists?(current_user.id)

    redirect_to dashboard_path
    end
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def property_params
    params.expect(property: [:address_line_one, :address_line_two, :postcode, :city, :state])
  end
end
