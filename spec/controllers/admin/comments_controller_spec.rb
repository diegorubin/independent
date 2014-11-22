require 'spec_helper'

describe Admin::CommentsController do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {

    FactoryGirl.create(:post)
    FactoryGirl.create(:presentation)

    @user = authenticate_user
  }

  context 'on list comments' do

    it 'unpublished' do
      get :index
      expect(assigns(:comments)).to be_kind_of(Hash)
    end

  end

end

