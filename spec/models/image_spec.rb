require 'spec_helper'

describe Image do

  let(:image) { FactoryGirl.build(:image) }

  context 'on validation' do

    after (:each) { expect(image.valid?).to be_falsey }

    it 'have a title' do
      image.title = ''
    end

  end

end

