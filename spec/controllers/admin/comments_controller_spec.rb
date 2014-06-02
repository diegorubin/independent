require 'spec_helper'

describe Admin::CommentsController do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on list comments' do

    it 'unpublished' do
      get :index
      expect(assigns(:comments)).to be_kind_of(Array)
    end

  end

end

