require 'spec_helper'

describe CommentsController do

  describe "on create" do

    let(:post_valid) {FactoryGirl.create(:post)}
    let(:comment_attributes) {FactoryGirl.attributes_for(:comment)}

    it 'save a valid comment' do
      post :create, content_type: 'Post', 
        content_id: post_valid.id, comment: comment_attributes

      post_valid.reload
      expect(response).to render_template('comments/success')
      expect(post_valid.comments.count).to eql(1)

    end

    it 'not save a invalid comment' do
      post :create, content_type: 'Post', 
        content_id: post_valid.id, comment: {name: ''}

      post_valid.reload
      expect(response).to render_template('comments/fail')
      expect(post_valid.comments.count).to eql(0)

    end
  end

end

