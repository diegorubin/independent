require 'spec_helper'

describe Setting do

  let(:setting) { FactoryGirl.build(:setting) }

  context 'on validation' do

    after (:each) { expect(setting.valid?).to be_falsey }

    it 'have a title' do
      setting.title = ''
    end

    it 'have a category' do
      setting.category = ''
    end

    it 'have a theme' do
      setting.theme = ''
    end

  end

  context 'on mapreduce functions' do

    context 'on map of settings' do
      before(:each) do
        Setting.destroy_all
        @title = FactoryGirl.create(:setting, title: 'title', theme: 'global')
        @subtitle = FactoryGirl.create(:setting, title: 'subtitle', theme: 'global')
        @about = FactoryGirl.create(:setting, title: 'current_theme', theme: 'global', value: 'theme')
        @theme = FactoryGirl.create(:setting, title: 'title', theme: 'theme')
      end

      it 'map settings by category' do
        expect(Setting.map_settings_by_category).to(
          eql({
            "global"=>{"title"=>"value", "subtitle"=>"value", "current_theme"=>"theme"}, 
            "theme"=>{"title"=>"value"}
          })
        )
      end

    end

  end

end

