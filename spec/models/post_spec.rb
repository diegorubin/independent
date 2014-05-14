require 'spec_helper'

describe Post do

  context "persist" do

    before(:each) do
      @post = FactoryGirl.build(:post, title: 'teste de post')
    end

    it "should save and retrieve a valid post" do
      @post.save.should be_true

      id = @post.id
      
      post = Post.find id
      post.title.should == @post.title
    end
    
    context "on slug" do

      it "should create a slug" do
        @post.save.should be_true
        @post.slug.should == "teste-de-post"
      end

      it "should choose my slug" do
        slug = "meu-slug-quero-assim"
        @post.slug = slug
        @post.save.should be_true
        @post.slug.should == slug
      end

      it "should create a date index" do
        date = Time.current.strftime("%Y/%m/%d")
        @post.published = true
        @post.save.should be_true
        @post.date.should == date
      end
      
    end

    context "on get resources" do

      it "should get post by date and slug" do
        post = FactoryGirl.create(:post, published: true)
        date = Time.current.strftime("%Y/%m/%d")

        Post.find_by_slug(date,post.slug).size.should == 1
      end

    end

  end

  context "on calculate pageviews" do
    
    it "should get a pageview" do

      post = FactoryGirl.create(:post, :pageviews => 15)
      post.get_pageviews.should == 15

    end

    it "should increment pageviews" do
      post = FactoryGirl.create(:post, :pageviews => 15)
      post.increment_pageviews.should be_true
    end

    it "should get pageviews from redis" do
      post = FactoryGirl.create(:post, :pageviews => 15)
      p = post.get_pageviews
      post.increment_pageviews

      post.get_pageviews.should == p+1
    end

  end

  context 'on put in list' do

    it 'create item' do
      expect{FactoryGirl.create(:post, published:true)}.
        to change(ListItem, :count).by(1)
    end

  end

end

