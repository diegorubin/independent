class Admin::CommentsController < Admin::BaseController

  before_filter :get_objects, only: [:update, :destroy]

  def index
    @comments = Comment.unpublisheds
  end

  def update
    if @comment.publish
      render template: 'admin/comments/published', layout: false
    else
      render template: 'admin/comments/published_fail', layout: false
    end
  end

  def destroy
    if @comment.destroy
      render template: 'admin/comments/destroyed', layout: false
    else
      render template: 'admin/comments/destroyed_fail', layout: false
    end
  end

  private
  def get_objects
    @object = params[:content_type].constantize.find(params[:parent_id])
    @comment = @object.find_comment_by_id(params[:id])
  end

  def get_object
  end

end

