module Commentable
  extend ActiveSupport::Concern

  MAP_FUNCTION = %q{
    function() {
      var content = this;

      show_comments = function(comments) {
        if(comments) {
          comments.forEach(function(comment){ 
            show_comments(comment.child_comments);
            if(!comment.published && !comment.removed) {

              new_comment = comment;
              new_comment.parent_id = content._id;

              emit(comment._id, comment); 
            }
          });
        }
      };
      show_comments(this.comments);
    }
  }

  REDUCE_FUNCTION = %q{
    function(key, values) {
      return values;
    }
  }

  included do
    embeds_many :comments, :as => :commentable

    def self.unpublished_comments
      with(collection: self.name.underscore.pluralize)
        .map_reduce(MAP_FUNCTION, REDUCE_FUNCTION).out(inline: 1)
    end
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

