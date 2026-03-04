class IssuesController < ApplicationController
    before_action :set_property
    before_action :set_issue, except: [:new, :create]
    before_action :authenticate_user, only:%i[show]
    def index

    end

    def new
        @issue = @property.issues.build
    end

    def show
    end

    def create
        @issue = @property.issues.build(issue_params)
        @issue.user = current_user
        if @issue.save
            redirect_to [@organization, @property]
        else
            render :new
        end
    end

    def update_status
        if @issue.update(status: params[:status])
            redirect_to [@organization, @property, @issue], notice: "Status updated successfully"
        else
            redirect_to [@organization, @property, @issue], notice: "FAILURE"
        end
    end

    def set_issue
        @issue = @property.issues.find(params[:id])
    end

    private

    def authenticate_user
    unless @organization.owner?(current_user) || @organization.users.exists?(current_user.id) || @property.users.exists?(current_user.id)

        redirect_to dashboard_path
    end
end


    def set_property
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
    end

    def issue_params
        params.expect(issue: [:title, :description, :incident_date, images: []])
    end
end
