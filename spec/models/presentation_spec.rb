require 'spec_helper'

describe Presentation do

  context "persist" do

    before(:each) do
      @valid_attrs = {:title => (0..5).map{('a'..'z').to_a[rand(26)]}.join, 
                      :resume => "um corpo"}
      @presentation = Presentation.new(@valid_attrs)
    end

    it "should save and retrieve a valid presentation" do
      @presentation.save.should be_true

      id = @presentation.id
      
      @presentation = Presentation.find id
      @presentation.title.should == @valid_attrs[:title]
    end
    
    context "on slug" do

      it "should create a slug" do
        @presentation.save.should be_true
        @presentation.slug.should == @valid_attrs[:title]
      end

      it "should choose my slug" do
        slug = (0..5).map{('a'..'z').to_a[rand(26)]}.join
        @presentation.slug = slug
        @presentation.save.should be_true
        @presentation.slug.should == slug
      end

    end

    context "on get resources" do

      it "should get presentation by date and slug" do
        presentation = Factory(:presentation)

        Presentation.find_by_slug(presentation.slug).size.should == 1
      end

    end

    context "export pdf to images" do

      it "should create slides" do
        presentation = Factory(:presentation)
        presentation.file = File.open(File.dirname(__FILE__) + "/examples/presentation.pdf")
        presentation.export = true
        presentation.save

        Presentation.export_images(presentation.id.to_s)

        presentation = Presentation.find(presentation.id.to_s)
        presentation.slides.size.should == 2
      end

    end

  end

end

