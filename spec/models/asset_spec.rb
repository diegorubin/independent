require 'spec_helper'

describe Asset do

  let(:asset) { FactoryGirl.build(:asset) }

  context 'on validation' do

    after (:each) {asset.valid?.should be_false }

    it 'have a title' do
      asset.title = ''
    end

    it 'have a file' do
      asset.file = ''
    end

  end

end

