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
    let(:image) { FactoryGirl.build(:image) }
    
    context 'insert image' do
      it 'from object' do
        gallery.images << image
        expect(gallery.images.first).to eql(image)
      end

      it 'from hash parameters' do
        image_attributes = image.attributes
        image_attributes['_id'] = nil

        gallery = Gallery.new(images_attributes: [image_attributes])
        expect(gallery.images.first).to eql(image)
      end
    end

  end

end

