require 'spec_helper'

describe Theme do

  let(:theme) { FactoryGirl.build(:theme) }

  context 'on validation' do

    after (:each) {expect(theme.valid?).to be_falsey }

    it 'have a title' do
      theme.title = ''
    end

    it 'have a label' do
      theme.label = ''
    end

  end

  context 'on manage themes' do

    before(:each) do
      Theme.destroy_all
      @file = File.open(File.dirname(__FILE__) + "/examples/test.zip")
    end

    context 'on import' do

      let(:theme) {FactoryGirl.create(:theme, file: @file)}

      it 'recover names' do
        expect(theme.title).to eql('Test')
        expect(theme.label).to eql('test')
      end

      it 'recover original manifest' do
        expect(theme.manifest).to be_kind_of(Hash)
      end

      it 'create theme settings' do
        clear_settings

        theme

        expect(Setting.count).to eql(1)
        expect(Setting.first.theme).to eql('test')
        expect(Setting.first.title).to eql('menu')
      end

      it 'copy theme files' do
        expect(theme.files.include?('javascripts/test.js')).to be_truthy
        expect(
          File.exists?(Theme.path.join('javascripts/test.js').to_s)
        ).to be_truthy
      end

    end

  end

end

