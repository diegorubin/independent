module Commentable
  extend ActiveSupport::Concern

  included do
    embeds_many :comments, :as => :commentable
  end

  def find_comment_by_id(comment_id)
    check_comments(comments,comment_id)
  end

  private
  def check_comments(comments,comment_id)
    comments.each do |comment|
      c = check_comments(comment.child_comments,comment_id)
      return c if c
      return comment if comment_id == comment.id.to_s
    end
    nil
  end

end

