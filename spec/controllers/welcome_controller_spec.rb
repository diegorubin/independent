require 'spec_helper'

describe WelcomeController, type: :controller do
  before(:each) {clear_settings}

  describe "GET 'index'" do

    before(:each) {get 'index'}

    it "returns http success" do
      expect(response).to be_success
    end

    it 'array of items' do
      clear_list
      FactoryGirl.create(:post, published: true)
      expect(assigns(:list_items).count).to eql(1)
    end

    context 'on filter by date' do
      let(:date_reference) {Time.local(2014,03,02)}
      let!(:post_previous_year) do 
        FactoryGirl.create(:list_item, published_at: date_reference - 1.year)
      end

      let!(:post_current_year) do 
        FactoryGirl.create(:list_item, published_at: date_reference)
      end

      it 'get all posts' do
        expect(assigns(:list_items).count).to eql(2)
      end
    end

  end

end

