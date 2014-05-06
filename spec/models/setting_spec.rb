require 'spec_helper'

describe Setting do

  let(:setting) { FactoryGirl.build(:setting) }

  context 'on validation' do

    after (:each) { setting.valid?.should be_false }

    it 'have an title' do
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
        @t1 = (0..5).map{('a'..'z').to_a[rand(26)]}.join
        @t2 = (0..5).map{('a'..'z').to_a[rand(26)]}.join
        @title = FactoryGirl.create(:setting, title: 'title', theme: @t1)
        @subtitle = FactoryGirl.create(:setting, title: 'subtitle', theme: @t1)
        @about = FactoryGirl.create(:setting, title: 'about', theme: @t1)
        @theme = FactoryGirl.create(:setting, title: 'title', theme: @t2)
      end

      it 'map settings by category' do
        expect(Setting.map_settings_by_category).to(
          be_kind_of(Mongoid::Contextual::MapReduce)
        )
      end

    end

  end

end

