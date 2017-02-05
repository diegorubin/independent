class Admin::CustomResourcesController < Admin::BaseController

  prepend_before_filter :prepend_view_paths

  def klass
    params[:resource_type].camelize.constantize
  end

  def object_params
    if params.has_key?(params[:resource_type])
      params.require(params[:resource_type]).permit!
    end
  end
end

