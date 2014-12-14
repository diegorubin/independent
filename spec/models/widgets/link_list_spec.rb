require 'spec_helper'

describe LinkList do

  context 'update lists' do

    it 'create list' do
      l = LinkList.create({'links_attributes' => {0 => {description: 'teste'}}})
      expect(l.links.count).to eql(1)
    end

    it 'update list' do
      l = LinkList.create({'links_attributes' => {0 => {description: 'teste'}}})
      attrs = l.links.first.attributes
      l.update({'links_attributes' => {0 => attrs.merge({description: 'updated'})}})
      expect(l.links.count).to eql(1)
      expect(l.links.first.description).to eql('updated')
    end

  end

end

