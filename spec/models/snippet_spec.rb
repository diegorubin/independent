require 'spec_helper'

describe Snippet do

  context "persist" do
    before(:each) do
      @valid_attrs = FactoryGirl.attributes_for :snippet
      @snippet= Snippet.new(@valid_attrs)
    end

    it "save and retrive a valid snippet" do
      expect(@snippet.save).to be_truthy

      id = @snippet.id

      @snippet = Snippet.find id
      expect(@snippet.title).to eql(@valid_attrs[:title])
    end

  end

  it "render in html" do
    snippet = Snippet.new(FactoryGirl.attributes_for :snippet)
    snippet.code = "#include<stdio.h>\nint main(){\n return 0;\n}"
    snippet.language = "c"

    expect(snippet.to_html).to eql("<pre class='sh_c'>#include&lt;stdio.h&gt;\nint main(){\n return 0;\n}</pre>")
  end

  it 'language_name' do
    snippet = FactoryGirl.create(:snippet)
    expect(snippet.language_name).to eql(Snippet::LANGUAGES[snippet.language])
  end

  it 'resume' do
    snippet = FactoryGirl.create(:snippet)
    expect(snippet.resume).to eql(
      I18n.t('admin.snippets.not_found')%(snippet.language_name))
  end

end

