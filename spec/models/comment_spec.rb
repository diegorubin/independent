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

    it "send an email to author" do
      comment = FactoryGirl.build(:comment, commentable: @post)
      expect { comment.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end 

    context 'on save commentator' do

      let(:comment) {FactoryGirl.create(:comment_published)}
      let(:comment2) {
        FactoryGirl.create(:comment_published, email: comment.email)
      }

      it 'add user to comentators list' do
        expect { comment }.to change(Commentator, :count).by(1)
      end

      it 'not duplicate commentator' do
        expect { 
          comment 
          comment2
        }.to change(Commentator, :count).by(1)
      end

      it 'auto approve comment if author is on the list' do
        comment
        comment_published = FactoryGirl.create(:comment, email: comment.email)
        expect(comment_published.published).to  be_truthy
      end
    end

  end

end

