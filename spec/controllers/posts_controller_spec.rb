require 'spec_helper'

describe PostsController do

  before(:each) {clear_settings}

  describe "GET 'index'" do

    before(:each) {get 'index'}

    it "returns http success" do
      expect(response).to be_success
    end

    it 'list only published posts' do
      published = FactoryGirl.create(:post, published: true)
      unpublished = FactoryGirl.create(:post)
      expect(assigns(:posts).first).to eql(published)
    end
  end

  context 'on show' do
    let(:published) {FactoryGirl.create(:post, published: true)}

    it 'show published post' do

      get 'show', date: published.date, slug: published.slug

      expect(response).to be_success
      expect(assigns(:post)).to eql(published)

    end

  end

end

