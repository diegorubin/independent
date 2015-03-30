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

  context 'on generate preview session' do

    let(:user) {FactoryGirl.create(:user)}

    before(:each) {
      @time_test = Time.local(2015,1,1)
      Time.stub(:current).and_return(@time_test)

      controller.stub(:current_user).and_return(user)
    }

    it 'generate hash for logged user' do
      expected_hash = 
        Digest::SHA1.hexdigest(user.username + @time_test.to_i.to_s)
      expect(helper.generate_preview_session()).to eql(expected_hash)
    end

  end

  context 'on tranlstes for javascript' do

    it 'get messages.save.success' do
      expect(helper.javascript_translates).to match(/messages.save.success/)
    end

    it 'get translate for messages.save.success' do
      expect(helper.javascript_translates).to match(/Salvo com sucesso./)
    end

  end

end

