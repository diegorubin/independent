require 'spec_helper'

describe Post do

  context "persist" do

    before(:each) do
      clear_posts
      @post = FactoryGirl.build(:post, title: 'teste de post')
    end

    it "save and retrieve a valid post" do
      expect(@post.save).to be_truthy

      id = @post.id
      
      post = Post.find id
      expect(post.title).to eql(@post.title)
    end
    
    context "on slug" do

      it "create a slug" do
        expect(@post.save).to be_truthy
        expect(@post.slug).to eql("teste-de-post")
      end

      it "choose my slug" do
        slug = "meu-slug-quero-assim"
        @post.slug = slug
        expect(@post.save).to be_truthy
        expect(@post.slug).to eql(slug)
      end

      it "create a date index" do
        date = Time.current.strftime("%Y/%m/%d")
        @post.published = true
        expect(@post.save).to be_truthy
        expect(@post.date).to eql(date)
      end
      
    end

    context "on get resources" do

      it "get post by date and slug" do
        post = FactoryGirl.create(:post, published: true)
        date = Time.current.strftime("%Y/%m/%d")

        expect(Post.find_by_slug(date,post.slug).size).to eql(1)
      end

    end

  end

  context "on calculate pageviews" do
    
    it "get a pageview" do

      post = FactoryGirl.create(:post, :pageviews => 15)
      expect(post.get_pageviews).to eql(15)

    end

    it "increment pageviews" do
      post = FactoryGirl.create(:post, :pageviews => 15)
      expect(post.increment_pageviews).to be_truthy
    end

    it "get pageviews from redis" do
      post = FactoryGirl.create(:post, :pageviews => 15)
      p = post.get_pageviews
      post.increment_pageviews

      expect(post.get_pageviews).to eql(p+1)
    end

  end

  context 'on put in list' do

    it 'create item' do
      expect{FactoryGirl.create(:post, published:true)}.
        to change(ListItem, :count).by(1)
    end

    it 'remove from list on remove item' do
      post = FactoryGirl.create(:post, published:true)
      expect{post.destroy}.to change(ListItem, :count).by(-1)
    end

    it 'update number of comments when new comment is published' do
      post = FactoryGirl.create(:post, published:true)
      post.comments << FactoryGirl.build(:comment)
      post.save

      post.comments.first.publish
      item = ListItem.find_by({resource_type: 'Post', resource_id: post.id})
      expect(item.number_of_comments).to eql(1)
    end

    context 'on generate index word list' do

      it 'remove stopwords' do
        FactoryGirl.create(:post, published:true, body: 'uma casa')

        item = ListItem.last
        expect(item.words_index).to eql(['casa'])
      end

    end

  end

  context 'on render article' do

    let(:post) {FactoryGirl.create(:post, body: 'blablabla[cite "content"]. bla')}

    it 'change citation to link' do
      expect(post.body.from_markdown_to_html).to(
        eql("<p>blablabla<a name='reference-1' href='#citation-1'>[1]</a>. bla</p>")
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
      expect(post.save).to be_truthy

      expect(Post.unpublished_comments.count).to eql(1)
    end

    context 'on count number of published comments' do

      it 'return 0 if not has comment' do
        post = FactoryGirl.create(:post)
        expect(post.number_of_comments).to eql(0)
      end

      it 'return number of published comments' do
        post = FactoryGirl.create(:post)
        post.comments << FactoryGirl.build(:comment, published: true)
        expect(post.save).to be_truthy

        expect(post.number_of_comments).to eql(1)
      end
    end

  end

  context 'on filter' do
    context 'title as regex' do

      let!(:post_matched) {FactoryGirl.create(:post, title: 'for filter')}
      let!(:post_not_matched) {FactoryGirl.create(:post, title: 'title')}

      it 'get one post' do
        expect(Post.filter_by('title' => 'for fil').count).to eq(1)
      end

    end
  end

end

