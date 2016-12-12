require 'rails_helper'

RSpec.describe SearchResults do
  let(:count) { 3 }
  let(:limit) { 5 }
  let(:source) { double('results', count: count) }
  let(:results) { described_class.new(source, limit: limit) }

  describe '#initialize' do
    it 'wraps a source' do
      expect(results).to eq(source)
    end

    it 'requires a limit' do
      expect { described_class.new(source) }.to raise_error(ArgumentError)
    end
  end

  describe '#current_page' do
    it 'defaults to 1' do
      expect(results.current_page).to eq(1)
    end

    it 'can be set by the :page argument' do
      results = described_class.new(source, limit: limit, page: 3)
      expect(results.current_page).to eq(3)
    end
  end

  describe '#limit_value' do
    it 'is the limit provided on initialization' do
      expect(results.limit_value).to eq(limit)
    end
  end

  describe '#offset_value' do
    subject(:offset) { results.offset_value }
    let(:results) { described_class.new(source, limit: limit, page: 4) }

    it 'is the offset of the current subset of the complete collection' do
      expect(offset).to eq(15)
    end
  end

  describe '#total_count' do
    subject(:total_count) { results.total_count }

    context 'when source has a count' do
      it 'is the source\'s count value' do
        expect(total_count).to eq(count)
      end
    end

    context 'when source does not have a count' do
      let(:results) { described_class.new(double('source'), limit: limit) }

      it { is_expected.to be_nil }
    end

    it 'can be overridden' do
      results = described_class.new(double('source'), limit: limit, total: 100)
      expect(results.total_count).to eq(100)
    end
  end

  describe '#total_pages' do
    let(:results) { described_class.new(source, limit: limit, total: 98) }
    subject(:pages) { results.total_pages }

    it 'is the total number of pages of the collection' do
      expect(results.total_pages).to eq(20)
    end
  end
end
