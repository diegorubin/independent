class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:destroy]

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

  def destroy
    begin
      post = Post.find(params[:pid])
    rescue
      post = Presentation.find(params[:pid])
    end

    comment = post.find_comment_by_id(params[:id])

    comment.removed = true

    alert = CommentAlert.find_by_postuid_and_commentid(post.id,comment.id)
    
    if comment.save && alert.destroy
      render :text => "Comentário removido com sucesso."
    else
      render :text => "Não foi possível remover o comentário."
    end
  end

  private
  def comment_params
    params.require(:comment).permit([:name, :site, :email, :body])
  end

end

