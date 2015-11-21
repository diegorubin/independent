class Admin::Api::V1::SpellcheckerController < Admin::ApiController
  skip_before_filter :check_api_key_pipeline

  before_filter :authenticate_user!
  before_filter :init_spellchecker

  skip_before_action :verify_authenticity_token

  def check
    render json: @spellchecker.check_text(params[:text]).to_json
  end

  def add
    render json: @spellchecker.add(params[:word], current_user.username).to_json
  end

  private
  def init_spellchecker
    @spellchecker = Spellchecker.new
  end

end

