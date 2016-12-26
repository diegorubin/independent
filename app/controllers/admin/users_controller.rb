class Admin::UsersController < Admin::BaseController
  
  include ApplicationHelper

  skip_before_filter :authenticate_user!, 
    unless: :admin_exists?, only: [:new, :create]

end

