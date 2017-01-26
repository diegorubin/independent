require 'spec_helper'

describe Contact do

  context "on persist" do

    before(:each) do
      @attrs = FactoryGirl.attributes_for :contact
    end

    it "save a contact" do
      contact = Contact.new(@attrs)
      expect(contact).to be_valid
    end

    it "send an email to users" do
      FactoryGirl.create(:user)
      contact = FactoryGirl.build(:contact)
      expect { contact .save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end 

  end

end

