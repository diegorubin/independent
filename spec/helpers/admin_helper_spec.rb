require 'spec_helper'

describe WelcomeHelper, type: :helper do
  
  context 'menu helpers' do

    it 'generate new button' do
      expect(helper.menu_button("Title", "#", "btn-primary"))
        .to eql("<a class=\"btn btn-primary\" href=\"#\">Title</a>")
    end

    it 'generate destroy button' do
      expect(helper.menu_button("Title", "#", "btn-danger", {'data-method' => 'destroy', 'confirm' => 'sure?'}))
        .to eql("<a class=\"btn btn-danger\" confirm=\"sure?\" data-method=\"destroy\" href=\"#\">Title</a>")

    end

  end

  context 'current action' do

    before(:each) { controller.stub(:action_name).and_return('new')}

    it 'return true if current action' do
      expect(helper.in_action?('new')).to be_truthy
    end

    it 'return false if not current action' do
      expect(helper.in_action?('edit')).to be_falsey
    end

  end

  context 'set menu item active' do

    before(:each) { controller.stub(:controller_name).and_return('posts')}

    it 'return true if current controller' do
      expect(helper.set_active('posts')).to eql('active')
    end

    it 'return false if not current controller' do
      expect(helper.set_active('welcome')).to be_blank
    end

  end

end

