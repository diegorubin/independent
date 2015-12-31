require 'spec_helper'

describe Admin::Api::V1::MarkdownController, type: :controller do
  before(:each) {@user = authenticate_user}

  context 'on render' do
    it 'mardown' do
      post 'create', markdown: '#test'
      expect(response.body).to eql("<h1>test</h1>\n")
    end
  end

end

