require 'rails_helper'

RSpec.describe TimeHelper, type: :helper do
  describe '#format_duration' do
    subject(:duration) { helper.format_duration(milliseconds) }

    context 'when duration >= 1 hour' do
      let(:milliseconds) { 3_600_000 }

      it 'is in the format H:MM:SS' do
        expect(duration).to eq('1:00:00')
      end
    end

    context 'when duration < 1 hour' do
      let(:milliseconds) { 452_503 }

      it 'is in the format M:SS' do
        expect(duration).to eq('7:32')
      end
    end
  end
end
