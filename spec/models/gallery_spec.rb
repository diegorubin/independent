require 'spec_helper'

describe Gallery do

  context 'on validation' do
    let(:gallery) { FactoryGirl.build(:gallery) }

    after (:each) { expect(gallery.valid?).to be_falsey }

    it 'have a title' do
      gallery.title = ''
    end
  end

end

