class CreateCommentator
  def initialize(comment)
    @comment = comment
  end

  def create
    commentator = Commentator.find_or_initialize_by(email: @comment.email) 
    commentator.name = @comment.name 
    commentator.save if commentator.new_record? && @comment.published

    if commentator.active && !@comment.published 
      @comment.update_attribute(:published, true) 
    end
  end
end
