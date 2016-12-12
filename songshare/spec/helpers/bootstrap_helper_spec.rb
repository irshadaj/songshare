require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#close_button' do
    subject(:button) { helper.close_button }

    it 'includes an X symbol' do
      expect(button).to include('&times;')
    end

    it 'dismisses an alert' do
      expect(button).to include('data-dismiss="alert"')
    end
  end
end
