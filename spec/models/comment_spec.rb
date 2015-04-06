require 'spec_helper'

describe Comment do

  context "on persist" do

    before(:each) do
      @attrs = FactoryGirl.attributes_for :comment

      @author = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, author: @author.username) 
    end

    it "save a comment" do
      c = Comment.new(@attrs)
      @post.comments << c
      expect(@post.save).to be_truthy
    end

    it "sends an email to author" do
      comment = FactoryGirl.build(:comment, commentable: @post)
      expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end 

  end

end

