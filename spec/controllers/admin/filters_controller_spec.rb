require 'spec_helper'

describe Admin::FiltersController, type: :controller do
  before(:each) {@user = authenticate_user}

  context 'on show' do
    it 'render template' do
      expect(response).to be_success
    end
  end

end

