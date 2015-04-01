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
        published_at = date_reference - 1.year
        FactoryGirl.create(:list_item, 
          published_at: published_at, date: published_at.strftime("%Y/%m/%d"))
      end

      let!(:post_current_year) do 
        FactoryGirl.create(:list_item, published_at: date_reference, 
          date: date_reference.strftime("%Y/%m/%d"))
      end

      let!(:post_previous_month) do 
        published_at = date_reference - 1.month
        FactoryGirl.create(:list_item, published_at: published_at, 
          date: published_at.strftime("%Y/%m/%d"))
      end

      let!(:post_previous_day) do 
        published_at = date_reference - 1.day
        FactoryGirl.create(:list_item, published_at: published_at, 
          date: published_at.strftime("%Y/%m/%d"))
      end

      it 'get all items' do
        expect(assigns(:list_items).count).to eql(4)
      end

      it 'get only posts in current year' do
        get 'index', date: '2014'
        expect(assigns(:list_items).count).to eql(3)
      end

      it 'get only posts in month' do
        get 'index', date: '2014/03'
        expect(assigns(:list_items).count).to eql(2)
      end

      it 'get only posts in day' do
        get 'index', date: '2014/03/02'
        expect(assigns(:list_items).count).to eql(1)
      end
    end

  end

end

