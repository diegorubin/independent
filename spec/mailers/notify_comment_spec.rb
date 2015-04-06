require 'spec_helper'

describe NotifyComment do
  describe 'notify' do

    let(:author) { FactoryGirl.build(:user) }
    let(:resource) { FactoryGirl.build(:post) }
    let(:comment) { FactoryGirl.build(:comment) }
    let(:mail) {NotifyComment.notify(author, resource, comment)}
 
    it 'renders the subject' do
      expect(mail.subject).to match(resource.title)
    end
 
    it 'renders the receiver email' do
      expect(mail.to).to eql([author.email])
    end
 
    it 'assigns author name' do
      expect(mail.body.encoded).to match(author.name)
    end

     it 'assigns user name and resource title' do
      expect(mail.body.encoded).to match(comment.name)
      expect(mail.body.encoded).to match(comment.email)
      expect(mail.body.encoded).to match(resource.title)
    end

     it 'assings comment body' do
      expect(mail.body.encoded).to match(comment.body)
     end

  end
end

