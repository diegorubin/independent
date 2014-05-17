class Admin::AssetsController < Admin::BaseController

  def show
    respond_to do |format|
      format.html { send_file @asset.file.path }
    end
  end

end

