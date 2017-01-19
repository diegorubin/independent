require 'spec_helper'

describe SettingsHelper, type: :helper do

  context 'on recover settings' do
    before(:each) do
      Setting.destroy_all
      FactoryGirl.create(
        :setting, theme: 'global', title: 'current_theme', value: 'default'
      )
      FactoryGirl.create(
        :setting, theme: 'default', title: 'subtitle', value: 'a site'
      )
    end

    it 'get current theme' do
      expect(helper.get_setting_value('global.current_theme')).to eql('default')
    end

    it 'resturn blank if not have setting' do
      expect(helper.get_setting_value('global.current_template')).to eql('')
    end

    it 'return attribute of current theme' do
      expect(helper.get_setting_value('theme.subtitle')).to eql('a site')
    end

  end

  context 'on check feature' do
    before(:each) do
      Setting.destroy_all
      FactoryGirl.create(
        :setting, theme: 'global', category: 'features', title: 'feature_enabled', value: 'enabled'
      )
      FactoryGirl.create(
        :setting, theme: 'global', category: 'features', title: 'feature_disabled', value: ''
      )
    end

    it 'return true if enabled' do
      expect(helper.feature_enabled?('feature_enabled')).to be_truthy
    end

    it 'return false if has another value' do
      expect(helper.feature_enabled?('feature_disabled')).to be_falsey
    end
  end

end

