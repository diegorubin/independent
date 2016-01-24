require 'spec_helper'

describe Admin::GalleriesController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on save gallery with image list' do

    let(:gallery_attributes) {FactoryGirl.attributes_for(:gallery)}
    let(:gallery_with_image_attributes) do 
      gallery = FactoryGirl.attributes_for(:gallery)
      gallery['items_attributes'] = [FactoryGirl.attributes_for(:gallery_item)]
      gallery
    end

    it 'create empty gallery' do
      post :create, gallery: gallery_attributes
      expect(assigns(:gallery).items.size).to eql 0
    end

    it 'create with image' do
      post :create, gallery: gallery_with_image_attributes
      expect(assigns(:gallery).items.size).to eql 1
      expect(response).to be_redirect
    end

  end

end

