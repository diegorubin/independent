require 'spec_helper'

describe Presentation do

  context "persist" do

    before(:each) do
      @valid_attrs = FactoryGirl.attributes_for(:presentation)
      @presentation = Presentation.new(@valid_attrs)
    end

    it "should save and retrieve a valid presentation" do
      @presentation.save.should be_truthy

      id = @presentation.id
      
      @presentation = Presentation.find id
      @presentation.title.should == @valid_attrs[:title]
    end
    
    context "on slug" do

      it "should create a slug" do
        @presentation.save.should be_truthy
        @presentation.slug.should == @valid_attrs[:title]
      end

      it "should choose my slug" do
        slug = (0..5).map{('a'..'z').to_a[rand(26)]}.join
        @presentation.slug = slug
        @presentation.save.should be_truthy
        @presentation.slug.should == slug
      end

    end

    context "on get resources" do

      it "should get presentation by date and slug" do
        presentation = FactoryGirl.create(:presentation)
        date = Time.current.strftime("%Y/%m/%d")

        Presentation.find_by_slug(date, presentation.slug).size.should == 1
      end

    end

    context "export pdf to images" do

      it "should create slides" do
        presentation = FactoryGirl.build(:presentation)
        presentation.file = File.open(File.dirname(__FILE__) + "/examples/presentation.pdf")
        presentation.save

        presentation.slides.size.should == 2
      end

    end

  end

end

