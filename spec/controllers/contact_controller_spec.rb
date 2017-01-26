require 'spec_helper'

describe ContactController, type: :controller do

  describe "on create" do

    let(:contact_attributes) { FactoryGirl.attributes_for(:contact) }

    it 'save a valid comment' do
      post :create, contact: contact_attributes
      expect(response).to render_template('contact/index')
      expect(Contact.count).to eql(1)
    end

    it 'not save a invalid comment' do
      post :create, contact: {name: ''}
      expect(response).to render_template('contact/index')
      expect(Contact.count).to eql(0)
    end
  end

end

