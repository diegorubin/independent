require 'spec_helper'

describe Comment do

  context "on persist" do

    before(:each) do
      @attrs = Factory.attributes_for :comment
    end

    it "should save a comment" do
      c = Comment.new(@attrs)
      post = Factory(:post)
      post.comments << c
      post.save.should be_true
    end
    
  end

end

