class Admin::BaseController < AdminController

  before_filter :get_object, :only => [:show, :edit, :update, :destroy]

  def index
    set_object_variable(klass.admin_list.page(params.fetch(:page,1)), false)
  end

  def new
    set_object_variable(klass.new)
  end

  def create
    set_object_variable(klass.new(object_params))
    if get_object_variable.save
      save_success_action
    else
      render :action => :new
      flash[:alert] = 
        :alert.t(:scope => [instance_variable_name, :admin, :create])
    end
  end

  def edit
  end

  def update
    if get_object_variable.update(object_params)
      respond_to do |format|
        format.html do
          save_success_action(:update)
        end
        format.json do 
          render json: get_object_variable
        end
      end
    else
      respond_to do |format|
        format.html do
          render action: :edit 
          flash[:alert] = 
            :alert.t(scope: [instance_variable_name, :admin, :udpate])
        end
        format.json do
          render json: {nothing: true}
        end
      end
    end
  end

  def show
  end

  def destroy
    if get_object_variable.destroy
      flash[:notice] = 
        :notice.t(:scope => [instance_variable_name, :admin, :destroy]) 
    else
      flash[:alert] = 
        :alert.t(:scope => [instance_variable_name, :admin, :destroy]) 
    end
    redirect_to :action => :index
  end
  

  protected
  def klass
    controller_name.classify.constantize
  end

  def instance_variable_name_pluralized
    controller_name
  end

  def instance_variable_name
    controller_name.singularize
  end

  def set_object_variable(value, singularized = true)
    variable_name = if singularized
                      instance_variable_name
                    else
                      instance_variable_name_pluralized
                    end

    instance_variable_set("@#{variable_name}", value)
  end

  def get_object_variable
    instance_variable_get("@#{instance_variable_name}")
  end

  def object_params
    if params.has_key?(instance_variable_name)
      params.require(instance_variable_name)
        .permit(klass.admin_attributes)
    end
  end

  def get_object
    set_object_variable(klass.find(params[:id]))
  end

  def save_success_action(act = :create)
    redirect_to action: :index
    flash[:notice] = :notice.t(:scope => [instance_variable_name, :admin, act])
  end

end

