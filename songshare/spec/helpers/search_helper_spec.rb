require 'rails_helper'

RSpec.describe SearchHelper, type: :helper do
  describe '#search_types' do
    subject(:types) { helper.search_types }

    it 'maps label to value' do
      types.each { |map| expect(map.length).to eq(2) }
    end
  end
end
