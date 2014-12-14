require 'spec_helper'

describe Admin::PostsController, type: :controller do

  before(:each) {@user = authenticate_user}

  let(:post_created) {FactoryGirl.create(:post)}

  context 'on list posts' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of posts' do
      expect(assigns(:posts)).to be_kind_of(Mongoid::Criteria)
    end

  end

  context 'on form for new post' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for new post' do
      expect(assigns(:post)).to be_kind_of(Post)
    end
   
  end

  context 'on create post' do
    let(:post_attributes) {FactoryGirl.attributes_for(:post)}
    let(:post_attributes_invalid) {FactoryGirl.attributes_for(:post_invalid)}

    it 'variable for new post' do
      post :create, :post => post_attributes
      expect(assigns(:post)).to be_kind_of(Post)
    end

    it 'save post' do
      post :create, :post => post_attributes
      expect(response).to be_redirect
    end

    it 'not save post' do
      post :create, :post => post_attributes_invalid
      expect(response).to be_success
    end

  end

  context 'on edit post' do
    before(:each) {get :edit, :id => post_created.id}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for post' do
      expect(assigns(:post)).to be_kind_of(Post)
      expect(assigns(:post)).to_not be_new_record
    end

  end

  context 'on update post' do

    it 'variable for post' do
      put :update, :id => post_created.id
      expect(assigns(:post)).to be_kind_of(Post)
      expect(assigns(:post)).to_not be_new_record
    end

    it 'save post' do
      put :update, :id => post_created.id, :post => {:body => 'novo corpo'}
      expect(response).to be_redirect
    end

    it 'not save post' do
      put :update, :id => post_created.id, :post => {:body => ''}
      expect(response).to be_success
    end

  end

  context 'on show post' do
    before(:each) {get :show, :id => post_created.id}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable for post' do
      expect(assigns(:post)).to be_kind_of(Post)
    end
   
  end

  context 'on destroy post' do

    it 'destroy object' do
      delete :destroy, :id => post_created.id
      expect(response).to be_redirect
    end

  end

end

