require 'spec_helper'

describe Admin::AssetsController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on list assets' do

    before(:each) {get :index}

    it 'variable with list of assets' do
      expect(assigns(:assets)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on recover asset file' do

    before(:each) do
      Theme.destroy_all
    end

    let(:asset) {FactoryGirl.create(:asset_with_file)}

    it 'get file' do
      get :show, id: asset.id, format: 'html'
      expect(response).to be_success
    end

  end

  context 'on create asset' do
    let(:asset_attributes) {FactoryGirl.attributes_for(:asset_with_file)}
    let(:asset_attributes_invalid) {FactoryGirl.attributes_for(:asset_invalid)}

    it 'variable for new asset' do
      post :create, :asset => asset_attributes
      expect(assigns(:asset)).to be_kind_of(Asset)
    end

    it 'not save asset' do
      post :create, :asset => asset_attributes_invalid
      expect(response).to be_success
    end

  end

end

