require 'spec_helper'

describe Admin::FilterFormHelper, type: :helper do
  describe '#render_filters_form' do
    context 'for Post' do
      let(:form) { helper.render_filters_form(Post) }
      it('have form') {expect(form).to match('form')}
    end
  end
end

