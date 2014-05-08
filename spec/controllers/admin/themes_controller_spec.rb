require 'spec_helper'

describe Admin::ThemesController do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}

  context 'on list themes' do

    before(:each) {get :index}

    it 'variable with list of themes' do
      expect(assigns(:themes)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on create theme' do
    let(:theme_attributes) {FactoryGirl.attributes_for(:theme)}
    let(:theme_attributes_invalid) {FactoryGirl.attributes_for(:theme_invalid)}

    it 'variable for new theme' do
      post :create, :theme => theme_attributes
      expect(assigns(:theme)).to be_kind_of(Theme)
    end

    it 'save theme' do
      post :create, :theme => theme_attributes
      expect(response).to be_redirect
    end

    it 'not save theme' do
      post :create, :theme => theme_attributes_invalid
      expect(response).to be_success
    end

  end

end

