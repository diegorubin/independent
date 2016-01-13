require 'spec_helper'

describe Admin::GalleriesController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on save gallery with image list' do

    let(:gallery_attributes) {FactoryGirl.attributes_for(:gallery)}

    it 'create empty gallery' do
      post :create, gallery: gallery_attributes
      expect(assigns(:gallery).images.count).to eql 0
    end

  end

end

