require 'spec_helper'

describe Link do
  context 'on form settings' do
    it 'icon defined' do
      expect(Link.new.form_field_defined?(:icon)).to be_truthy
    end

    it 'icon as image field' do
      expect(Link.new.form_field_type(:icon)).to eql('image')
    end

  end
end

