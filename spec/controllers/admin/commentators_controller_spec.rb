require 'spec_helper'

describe Admin::CommentatorsController, type: :controller do

  before(:each) {@user = authenticate_user}

  context 'on deactive commentator' do

    let(:commentator_active) {FactoryGirl.create(:commentator)}
    let(:commentator_inactive) {FactoryGirl.create(:commentator_inactive)}

    it 'deactive' do
      patch :update, id: commentator_active.id, commentator: {active: false}, format: :json
      commentator_active.reload
      expect(commentator_active.active).to be_falsey
    end

    it 'active' do
      patch :update, id: commentator_inactive.id, commentator: {active: false}, format: :json
      commentator_inactive.reload
      expect(commentator_inactive.active).to be_falsey
    end

  end

end

