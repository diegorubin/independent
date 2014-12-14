require 'spec_helper'

describe Image do

  let(:image) { FactoryGirl.build(:image) }

  context 'on validation' do

    after (:each) {image.valid?.should be_falsey }

    it 'have a title' do
      image.title = ''
    end

  end

end

