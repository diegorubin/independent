require 'spec_helper'

describe Admin::PagesController do

  before(:each) {@user = authenticate_user}

  let(:page_created) {FactoryGirl.create(:page)}

  context 'on list pages' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of pages' do
      expect(assigns(:pages)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on form for new page' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for new page' do
      expect(assigns(:page)).to be_kind_of(Page)
    end
   
  end

  context 'on create page' do
    let(:page_attributes) {FactoryGirl.attributes_for(:page)}
    let(:page_attributes_invalid) {FactoryGirl.attributes_for(:page_invalid)}

    it 'variable for new page' do
      post :create, :page => page_attributes
      expect(assigns(:page)).to be_kind_of(Page)
    end

    it 'save page' do
      post :create, :page => page_attributes
      expect(response).to be_redirect
    end

    it 'not save page' do
      post :create, :page => page_attributes_invalid
      expect(response).to be_success
    end

  end

end

