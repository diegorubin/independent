require 'spec_helper'

describe Snippet do

  context "persist" do
    before(:each) do
      @valid_attrs = FactoryGirl.attributes_for :snippet
      @snippet= Snippet.new(@valid_attrs)
    end

    it "should save and retrive a valid snippet" do
      @snippet.save.should be_truthy

      id = @snippet.id

      @snippet = Snippet.find id
      @snippet.title.should == @valid_attrs[:title]
    end

  end

  it "should render in html" do
    snippet = Snippet.new(FactoryGirl.attributes_for :snippet)
    snippet.code = "#include<stdio.h>\nint main(){\n return 0;\n}"
    snippet.language = "c"

    snippet.to_html.should == "<pre class='sh_c'>#include&lt;stdio.h&gt;\nint main(){\n return 0;\n}</pre>"
  end

end

