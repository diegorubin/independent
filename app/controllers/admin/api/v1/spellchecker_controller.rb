class Admin::Api::V1::SpellcheckerController < Admin::ApiController
  skip_before_filter :check_api_key_pipeline
  before_filter :authenticate_user!

  def show
    spellchecker = Spellchecker.new(params[:word])
    render json: spellchecker.to_json
  end

end

