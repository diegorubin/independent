class Admin::ThemesController < Admin::BaseController

  def show
    respond_to do |format|
      format.zip { send_file @theme.file.path }
    end
  end

end

