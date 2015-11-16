class Admin::Api::V1::SpellcheckerController < Admin::ApiController
  skip_before_filter :check_api_key_pipeline
  before_filter :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    spellchecker = Spellchecker.new
    render json: spellchecker.check_text(params[:text]).to_json
  end

end

