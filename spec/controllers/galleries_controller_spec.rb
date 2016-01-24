require 'spec_helper'

describe GalleriesController, type: :controller do

  context 'on show' do
    let(:published) {FactoryGirl.create(:gallery, published: true)}

    it 'show published gallery' do

      get 'show', date: published.date, slug: published.slug

      expect(response).to be_success
      expect(assigns(:gallery)).to eql(published)

    end

  end

end

