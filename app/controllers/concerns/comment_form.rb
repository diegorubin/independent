module CommentForm
  include SettingsHelper

  protected
  def show_comment_form
    if feature_enabled?('comments')
      @comment = Comment.new
    end
  end

end

