require 'spec_helper'

describe Presentation do

  context "persist" do

    before(:each) do
      @valid_attrs = FactoryGirl.attributes_for(:presentation)
      @presentation = Presentation.new(@valid_attrs)
    end

    it "save and retrieve a valid presentation" do
      expect(@presentation.save).to be_truthy

      id = @presentation.id
      
      @presentation = Presentation.find id
      expect(@presentation.title).to eql(@valid_attrs[:title])
    end
    
    context "on slug" do

      it "create a slug" do
        expect(@presentation.save).to be_truthy
        expect(@presentation.slug).to eql(@valid_attrs[:title])
      end

      it "choose my slug" do
        slug = (0..5).map{('a'..'z').to_a[rand(26)]}.join
        @presentation.slug = slug
        expect(@presentation.save).to be_truthy
        expect(@presentation.slug).to eql(slug)
      end

    end

    context "on get resources" do

      it "get presentation by date and slug" do
        presentation = FactoryGirl.create(:presentation)
        date = Time.current.strftime("%Y/%m/%d")

        expect(Presentation.find_by_slug(date, presentation.slug).size).to eql(1)
      end

    end

    context "export pdf to images" do

      it "create slides" do
        presentation = FactoryGirl.build(:presentation)
        presentation.file = File.open(File.dirname(__FILE__) + "/examples/presentation.pdf")
        presentation.save

        expect(presentation.slides.size).to eql(2)
      end

    end

  end

end

