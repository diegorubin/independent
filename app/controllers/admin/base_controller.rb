class Admin::BaseController < AdminController

  before_filter :get_object, :only => [:edit, :update, :destroy]

  def index
    instance_variable_set(
      "@#{instance_variable_name_pluralized}", 
      klass.admin_list.page(params.fetch(:page,1))
    )
  end

  def new
    @object = klass.new
  end

  protected
  def klass
    controller_name.singularize.camelize.constantize
  end

  def instance_variable_name_pluralized
    controller_name
  end

end

