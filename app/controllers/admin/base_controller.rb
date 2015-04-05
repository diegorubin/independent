class Admin::BaseController < AdminController

  before_filter :get_object, :only => [:edit, :update, :destroy]

  def index
    @page = params.fetch(:page,1)
    set_object_variable(klass.admin_list.page(@page), false)
    respond_to do |format|
      format.html {}
      format.json do
        render json: {
          'page' => @page,
          'total' => get_object_variable(false).count,
          'result' => get_object_variable(false)
        }
      end
    end
  end

  def new
    set_object_variable(klass.new)
  end

  def create
    set_object_variable(klass.new(object_params))
    yield(get_object_variable) if block_given?
    if get_object_variable.save
      save_success_action
    else
      error_with_format(:new, :create)
    end
  end

  def edit
  end

  def update
    yield(get_object_variable) if block_given?
    if get_object_variable.update(object_params)
      save_success_action(:update)
    else
      error_with_format(:edit, :update)
    end
  end

  def show
    if params[:id] == 'preview'
      set_object_variable(klass.new(object_params))
    else
      get_object
    end
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

  def get_object_variable(singularized = true)
    if singularized
      instance_variable_get("@#{instance_variable_name}")
    else
      instance_variable_get("@#{instance_variable_name_pluralized}")
    end
  end

  def object_params
    if params.has_key?(instance_variable_name)
      params.require(instance_variable_name).permit!
    end
  end

  def get_object
    set_object_variable(klass.find(params[:id]))
  end

  def save_success_action(act = :create)
    respond_to do |format|
      format.html do
        redirect_to action: :index
        flash[:notice] = :notice.t(:scope => [instance_variable_name, :admin, act])
      end

      format.json do
        render json: get_object_variable
      end
    end
  end

  def error_with_format(action, alert)
    respond_to do |format|
      format.html do
        render :action => action
        flash[:alert] = 
          :alert.t(:scope => [instance_variable_name, :admin, alert])
      end

      format.json do
        render json: get_object_variable
      end
    end
  end

end

