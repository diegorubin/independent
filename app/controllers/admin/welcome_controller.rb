class Admin::WelcomeController < AdminController
  def index
    @unpublished_comments = Comment.count_unpublisheds
  end
end
