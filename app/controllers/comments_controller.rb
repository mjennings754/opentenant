class CommentsController < ApplicationController
    before_action :set_property, :set_issue

    def create
        @comment = @issue.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to [@organization, @property, @issue], notice: "Comment created"
        else
            render "issues/show", status: :unprocessable_entity
        end
    end


private

    def set_property
        @property = Property.find(params[:property_id])
        @organization = Organization.find(params[:organization_id])
    end

    def set_issue
        @issue = @property.issues.find(params[:issue_id])
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end
