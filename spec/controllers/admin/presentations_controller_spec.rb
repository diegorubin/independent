require 'spec_helper'

describe Admin::PresentationsController do

  before(:each) {@user = authenticate_user}

  let(:presentation_created) {FactoryGirl.create(:presentation)}

  context 'on list presentations' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of presentations' do
      expect(assigns(:presentations)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on form for new presentation' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for new presentation' do
      expect(assigns(:presentation)).to be_kind_of(Presentation)
    end
   
  end

  context 'on create presentation' do
    let(:presentation_attributes) {FactoryGirl.attributes_for(:presentation)}
    let(:presentation_attributes_invalid) {FactoryGirl.attributes_for(:presentation_invalid)}

    it 'variable for new presentation' do
      post :create, :presentation => presentation_attributes
      expect(assigns(:presentation)).to be_kind_of(Presentation)
    end

    it 'save presentation' do
      post :create, :presentation => presentation_attributes
      expect(response).to be_redirect
    end

    it 'not save presentation' do
      post :create, :presentation => presentation_attributes_invalid
      expect(response).to be_success
    end

  end

end

