require 'spec_helper'

describe Gallery do

  context 'on validation' do
    let(:gallery) { FactoryGirl.build(:gallery) }

    after (:each) { expect(gallery.valid?).to be_falsey }

    it 'have a title' do
      gallery.title = ''
    end
  end

  context 'on associate images' do
    let(:gallery) { FactoryGirl.build(:gallery) }
    let(:item) { FactoryGirl.build(:gallery_item) }
    
    context 'insert item' do
      it 'from object' do
        gallery.items << item 
        expect(gallery.items.first).to eql(item)
      end

      it 'from hash parameters' do
        item_attributes = item.attributes
        item_attributes['_id'] = nil

        gallery = Gallery.new(items_attributes: [item_attributes])
        expect(gallery.items.first).to eql(item)
      end
    end

  end

end

