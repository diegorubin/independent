require 'spec_helper'

describe Admin::SnippetsController do

  before(:each) {@user = authenticate_user}

  let(:snippet_created) {FactoryGirl.create(:snippet)}

  context 'on list snippets' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of snippets' do
      expect(assigns(:snippets)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on form for new snippet' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for new snippet' do
      expect(assigns(:snippet)).to be_kind_of(Snippet)
    end
   
  end

  context 'on create snippet' do
    let(:snippet_attributes) {FactoryGirl.attributes_for(:snippet)}
    let(:snippet_attributes_invalid) {FactoryGirl.attributes_for(:snippet_invalid)}

    it 'variable for new snippet' do
      post :create, :snippet => snippet_attributes
      expect(assigns(:snippet)).to be_kind_of(Snippet)
    end

    it 'save snippet' do
      post :create, :snippet => snippet_attributes
      expect(response).to be_redirect
    end

    it 'not save snippet' do
      post :create, :snippet => snippet_attributes_invalid
      expect(response).to be_success
    end

  end

end

