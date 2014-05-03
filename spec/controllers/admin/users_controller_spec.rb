require 'spec_helper'

describe Admin::UsersController do

  before(:each) {@user = authenticate_user}

  let(:user_created) {FactoryGirl.create(:user)}

  context 'on list users' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

  end

  context 'on form for new user' do
    before(:each) {get :new}

    it 'render template' do
      expect(response).to be_success
    end

  end

  context 'on edit user' do
    before(:each) {get :edit, :id => user_created.id}

    it 'render template' do
      expect(response).to be_success
    end

  end

  context 'on show user' do
    before(:each) {get :show, :id => user_created.id}

    it 'render template' do
      expect(response).to be_success
    end
  end

end

