require 'spec_helper'

describe Admin::WidgetsController, type: :controller do

  context 'on link list' do
    context 'configure' do
      
      before(:each) { LinkList.destroy_all }

      let(:widget) do 
        Widget.find_or_create_by(label: 'link_list', 
          manifest: {'widget' => {'config_model' => 'LinkList'}})
      end

      let(:config) { LinkList.create }


      it 'name' do
        patch :update, id: widget.id, link_list: {title: 'teste'}
        expect(response).to be_redirect
      end

    end
  end

end

