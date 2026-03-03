class IssuesController < ApplicationController

    def index
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
    end

    def new
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
        @issue = @property.issues.build
    end

    def create
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
        @issue = @property.issues.build(issue_params)
        @issue.user = current_user
        if @issue.save
            redirect_to [@organization, @property]
        else
            render :new
        end
    end

    private

    def issue_params
        params.expect(issue: [:title, :description, :incident_date])
    end
end
