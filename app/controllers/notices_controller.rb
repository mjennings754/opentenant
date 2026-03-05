class NoticesController < ApplicationController
    before_action :set_property
    def new
        @notice = @property.notices.build
    end

    def create
        @notice = @property.notices.build(notice_params)
        @notice.user = current_user
        if @notice.save
            redirect_to [@organization, @property], notice: "Notice has been pushed"
        else
            render :new, notice: "error"
        end
    end

    def show
        @notice = Notice.find(params[:id])
    end

    def set_property
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
    end

    private

    def notice_params
        params.expect(notice: [:title, :description])
    end

end
