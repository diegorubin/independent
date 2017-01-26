class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:destroy]
  layout :set_current_theme
  prepend_before_filter :prepend_view_paths


  def create
    content_type = params[:content_type]

    @commentable = 
      content_type.constantize.find(params[:content_id])
    
    @comment = Comment.new(comment_params)

    if params[:commentid].blank?
      @commentable.comments << @comment
    else
      comment = @commentable.find_comment_by_id(params[:commentid])
      comment.child_comments << @comment
    end

    if @comment.errors.size == 0 && (!@answer)
      render :template => "comments/success",
             :layout => false
    else
      render :template => "comments/fail",
             :layout => false
    end
  end

  private
  def comment_params
    params.require(:comment).permit([:name, :site, :email, :body])
  end

end

