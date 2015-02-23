require 'spec_helper'

describe ApiKey do

  let(:api_key) { FactoryGirl.build(:api_key) }

  context 'on validation' do

    after (:each) { expect(api_key.valid?).to be_falsey }

    it 'have a user_id' do
      api_key.user_id = ''
    end

    it 'have a program' do
      api_key.program = ''
    end

    it 'have a permissions' do
      api_key.permissions = nil
    end

  end

  context 'on create apit key' do

    it 'generate key' do
      api_key.save
      expect(api_key.key).to_not be_blank
    end

  end

  context 'utils methods' do
    it 'retrive user' do
      expect(api_key.user).to be_kind_of(User)
    end
  end

end

