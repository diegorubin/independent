require 'spec_helper'

describe GalleryItem do

  context 'on recover image url' do

    let(:image) { FactoryGirl.create(:image) }
    let(:gallery) { FactoryGirl.create(:gallery) }

    let(:gallery_item_valid) do 
      FactoryGirl.create(:gallery_item, gallery: gallery, slug: image.slug) 
    end

    let(:gallery_item_invalid) do 
      FactoryGirl.create(:gallery_item, gallery: gallery, slug: 'teste') 
    end

    it 'returns valid url if valid image' do
      expect(gallery_item_valid.image_url(:thumb)).to_not eql('/images/thumb_fallback.png')
    end

    it 'returns fallback if invalid image' do
      expect(gallery_item_invalid.image_url(:thumb)).to eql('/images/thumb_fallback.png')
    end

  end

end

