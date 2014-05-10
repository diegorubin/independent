require 'spec_helper'

describe Page do

  let(:page) { FactoryGirl.build(:page) }

  context 'on validation' do

    after (:each) {page.valid?.should be_false }

    it 'have a title' do
      page.title = ''
    end

    it 'have a body' do
      page.body = ''
    end

  end

end

