class DashboardController < ApplicationController
  before_action :require_login
  def home
    @organizations = current_user.all_organizations
    @properties = current_user.properties
  end
end
