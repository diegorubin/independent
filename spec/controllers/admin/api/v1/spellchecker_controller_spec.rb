require 'spec_helper'

describe Admin::Api::V1::SpellcheckerController, type: :controller do
  before(:each) {@user = authenticate_user}
end

