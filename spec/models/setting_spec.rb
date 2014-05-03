require 'spec_helper'

describe Setting do

  let(:setting) { FactoryGirl.build(:setting) }

  context 'on validation' do

    after (:each) { setting.valid?.should be_false }

    it 'have an title' do
      setting.title = ''
    end

    it 'have a category' do
      setting.category = ''
    end

  end

end

