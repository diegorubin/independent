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
      
      context 'when list images' do
        let!(:image) {FactoryGirl.create(:image)}

        before(:each) do 
          get :index, format: 'json'
          @json = JSON.load(response.body)
        end

        it('result as hash') {expect(@json).to be_kind_of(Hash)}
        it('have total') {expect(@json['total']).to eql(1)}
        it('have page') {expect(@json['page']).to eql(1)}
        it('have list of images') {expect(@json['result']).to be_kind_of(Array)}
      end

      context 'when create images' do

        context 'when success' do

          let(:image_attributes) {FactoryGirl.attributes_for(:image)}

          before(:each) do 
            get :create, format: 'json', image: image_attributes
            @json = JSON.load(response.body)
          end

          it('result as hash') {expect(@json).to be_kind_of(Hash)}
          it('have status') {expect(response.status).to eql(200)}

        end

        context 'when error' do

          let(:image_attributes) {FactoryGirl.attributes_for(:image, title: '')}

          before(:each) do 
            get :create, format: 'json', image: image_attributes
            @json = JSON.load(response.body)
          end

          it('result as hash') {expect(@json).to be_kind_of(Hash)}
          it('have status') {expect(response.status).to eql(422)}

        end

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

