require 'spec_helper'

describe Theme do

  let(:theme) { FactoryGirl.build(:theme) }

  context 'on validation' do

    after (:each) {theme.valid?.should be_false }

    it 'have a title' do
      theme.title = ''
    end

    it 'have a label' do
      theme.label = ''
    end

  end

end

