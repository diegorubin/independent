require 'spec_helper'

describe Admin::ImagesController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on list images' do

    before(:each) {get :index}

    it 'variable with list of images' do
      expect(assigns(:images)).to be_kind_of(Mongoid::Criteria)
    end

    context 'as json' do
      it 'list all images' do
        get :index, format: 'json'
        expect(JSON.load(response.body)).to be_kind_of(Array)
      end
    end

  end

  context 'on create image' do
    let(:image_attributes) {FactoryGirl.attributes_for(:image)}
    let(:image_attributes_invalid) {FactoryGirl.attributes_for(:image_invalid)}

    it 'variable for new image' do
      post :create, :image => image_attributes
      expect(assigns(:image)).to be_kind_of(Image)
    end

    it 'not save image' do
      post :create, :image => image_attributes_invalid
      expect(response).to be_success
    end

  end

end

