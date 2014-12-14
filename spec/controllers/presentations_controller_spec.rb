require 'spec_helper'

describe PresentationsController, type: :controller do

  before(:each) {clear_settings}

  describe "GET 'index'" do

    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

  end

  context 'on show' do
    let(:published) {FactoryGirl.create(:presentation, published: true)}

    it 'show published presentation' do

      get 'show', date: published.date, slug: published.slug

      expect(response).to be_success
      expect(assigns(:presentation)).to eql(published)

    end

  end

end

