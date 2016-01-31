require 'spec_helper'

describe ApplicationHelper, type: :helper do

  context 'return class' do

    before(:each) { allow(controller).to receive(:controller_name).and_return('posts')}

    it 'return klass if current controller' do
      expect(helper.return_if_active('posts', 'current_page_item')).to(
        eql('current_page_item')
      )
    end

    it 'return blank if not current controller' do
      expect(helper.return_if_active('welcome', 'current_page_item')).to be_blank
    end

  end

  context 'on return correct link of item' do

    xit 'to post' do
      item = FactoryGirl.create(:list_item, 
        resource_type: 'Post', date: '01/01/2014', slug: 'item'
      )
      expect(helper.item_path(item)).to eql('/posts/01/01/2014/item')
    end

  end

  context 'on render footnotes' do

    it 'empty footnotes' do
      footnotes = helper.render_footnotes([])
      expect(footnotes).to eql('')
    end

    it 'with simple text' do
      footnotes = helper.render_footnotes(['foo bar'])
      expect(footnotes).to eql('<h2>Notas</h2><div class="footnotes"><p><span><a href="#reference-1" name="footnote1">[1]</a></span> foo bar</p></div>')
    end

  end

end

