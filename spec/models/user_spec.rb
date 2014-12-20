require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context 'on validation' do

    after (:each) { expect(user.valid?).to be_falsey }

    it 'have an email' do
      user.email = ''
    end

    it 'have a name' do
      user.name = ''
    end

    it 'have an username' do
      user.username = ''
    end

  end
  
end

