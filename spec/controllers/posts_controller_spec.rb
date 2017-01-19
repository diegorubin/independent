require 'spec_helper'

describe PostsController, type: :controller do

  before(:each) {clear_settings}

  describe "GET 'index'" do

    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    context 'on list' do
      before(:each) {
        category_test_list = 'test_list'
        @published = FactoryGirl.create(
          :post, published: true, category: category_test_list, 
                 tags: 'inicio,meio,fim'
        )
      }

      it 'only published posts' do
        get 'index'
        unpublished = FactoryGirl.create(:post)
        expect(assigns(:posts).first).to eql(@published)
      end

      it 'by category' do
        get 'index', category: @published.category
        expect(assigns(:posts).first).to eql(@published)
      end

      context 'by tag' do

        it 'case 1' do
          get 'index', tag: 'inicio'
          expect(assigns(:posts).first).to eql(@published)
        end

        it 'case 2' do
          get 'index', tag: 'meio'
          expect(assigns(:posts).first).to eql(@published)
        end

        it 'case 3' do
          get 'index', tag: 'fim'
          expect(assigns(:posts).first).to eql(@published)
        end

      end

    end
  end

  context 'on show' do
    let(:published) {FactoryGirl.create(:post, published: true)}

    it 'show published post' do

      get 'show', date: published.date, slug: published.slug

      expect(response).to be_success
      expect(assigns(:post)).to eql(published)

    end

    context 'use widgets' do

      let!(:html_container) {FactoryGirl.create(:html_container)}

      before(:each) do

        it 'assign widgets for page' do
          get 'show', date: published.date, slug: published.slug
          expect(assings(:html_container)).to eql(html_container)
        end
        
      end
    end

  end

end

