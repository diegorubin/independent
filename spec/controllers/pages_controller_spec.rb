require 'spec_helper'

describe PagesController do

  before(:each) {clear_settings; clear_pages}

  context 'on show' do
    let(:published) {FactoryGirl.create(:page, published: true)}

    it 'show published page' do

      get 'show', slug: published.slug

      expect(response).to be_success
      expect(assigns(:page)).to eql(published)

    end

  end

end

