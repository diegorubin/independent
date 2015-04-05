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
 
    it 'assigns @name' do
      expect(mail.body.encoded).to match(author.name)
    end
 
  end
end

