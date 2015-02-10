require 'spec_helper'

describe Image do

  let(:image) { FactoryGirl.build(:image) }

  context 'on validation' do

    after (:each) { expect(image.valid?).to be_falsey }

    it 'have a title' do
      image.title = ''
    end

  end

  context 'on tags' do

    let(:tags) { 'slider, test' }
    let(:image) { FactoryGirl.build(:image, tags: tags) }

    it 'get array of tags' do
      expect(image.tags_list).to eql(['slider', 'test'])
    end

    it 'recover image for a tag' do
      suffix = Image.count + 1
      image.tags = "image-#{suffix}, tag"
      image.save

      expect(Image.for_tag("image-#{suffix}").last).to eql(image)
    end

  end

end

