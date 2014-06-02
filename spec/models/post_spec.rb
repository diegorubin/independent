require 'spec_helper'

describe Post do

  context "persist" do

    before(:each) do
      clear_posts
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

  context 'on render article' do

    let(:post) {FactoryGirl.create(:post, body: 'blablabla[cite "content"]. bla')}

    it 'change citation to link' do
      expect(post.body.from_markdown_to_html).to(
        eql("<p>blablabla<a href='#citation-1'>[1]</a>. bla</p>")
      )
    end

    it 'show footnotes' do
      expect(post.footnotes).to(
        eql(["<p>\"content\"</p>"])
      )

    end
    
  end

  context 'on recover comments' do

    it 'execute map reduce functions' do
      expect {Post.unpublished_comments}.to_not raise_error
    end

    it 'no comment' do
      expect(Post.unpublished_comments.count).to eql(0)
    end

    it '1 unpublished comment' do

      post = FactoryGirl.create(:post)
      post.comments << FactoryGirl.build(:comment)
      expect(post.save).to be_true

      expect(Post.unpublished_comments.count).to eql(1)
    end

  end

end

