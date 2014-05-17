class AssetsController < ApplicationController

  layout :set_current_theme

  prepend_before_filter :prepend_view_paths
  skip_before_action :verify_authenticity_token, only: [:show]

  def show
    asset = Asset.publisheds.find_by_simple_slug(params[:slug]).first
    raise RecordNotFound unless asset

    send_file asset.file.path
  end

end

