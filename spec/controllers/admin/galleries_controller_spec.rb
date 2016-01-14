require 'spec_helper'

describe Admin::GalleriesController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on save gallery with image list' do

    let(:gallery_attributes) {FactoryGirl.attributes_for(:gallery)}
    let(:gallery_with_image_attributes) do
      gallery = FactoryGirl.attributes_for(:gallery)
      gallery['images_attributes'] = [FactoryGirl.attributes_for(:image)]
      gallery['images_attributes'][0]['file'] = Rack::Test::UploadedFile.new(
        image_example_path, 'image/jpeg')
      gallery
    end

    it 'create empty gallery' do
      post :create, gallery: gallery_attributes
      expect(assigns(:gallery).images.size).to eql 0
    end

    it 'create with image' do
      post :create, gallery: gallery_with_image_attributes
      expect(assigns(:gallery).images.size).to eql 1
      expect(response).to be_redirect
    end

  end

end

