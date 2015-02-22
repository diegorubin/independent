class Admin::ApiController < ApplicationController

  before_filter :check_api_key_pipeline

  def index
    render json: klass.all
  end

  protected
  def check_api_key_pipeline
    unless check_api_key && check_permissions
      render nothing: true,  status: 401
      return
    end
  end

  def check_api_key
    @api_key = ApiKey.where(key: params[:api_key]).first
  end

  def check_permissions
    @api_key.permissions.with_indifferent_access[resource]
      .include?(action)
  end

  def api_key_user
    @api_key.user
  end

  def resource
    controller_name
  end

  def action
    action_name
  end

end

