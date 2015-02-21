class Admin::ApiKeysController < Admin::BaseController

  def create
    super {|api_key| api_key.user_id = current_user.id.to_s}
  end

end

