require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context 'on validation' do

    after (:each) { user.valid?.should be_false }

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

