require 'spec_helper'

describe Admin::PostsController do

  context 'on list posts' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of posts' do
      expect(assigns(:posts)).to be_kind_of(Mongoid::Criteria)
    end

  end

end

