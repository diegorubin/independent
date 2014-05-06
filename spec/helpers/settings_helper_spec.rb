require 'spec_helper'

describe SettingsHelper do

  context 'on recover settings' do
    before(:each) do
      Setting.destroy_all
      FactoryGirl.create(
        :setting, theme: 'global', title: 'current_theme', value: 'default'
      )
    end

    it 'get current theme' do
      expect(helper.get_setting_value('global.current_theme')).to eql('default')
    end

    it 'resturn blank if not have setting' do
      expect(helper.get_setting_value('global.current_template')).to eql('')
    end
  end

end

