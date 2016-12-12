require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { build_stubbed(:friendship) }
  let(:inverse) { build(:friendship, user: friendship.friend, friend: friendship.user) }

  it 'must be unique' do
    create(:friendship, user: friendship.user, friend: friendship.friend)

    expect(friendship).not_to be_valid
  end

  describe '#confirmed?' do
    subject(:confirmed) { friendship.confirmed? }

    context 'when the inverse friendship exists' do
      before(:each) { inverse.save }

      it { is_expected.to be true }
    end

    context 'when an inverse friendship does not exist' do
      it { is_expected.to be false }
    end
  end

  describe '#friend' do
    it 'is required' do
      friendship.friend = nil
      expect(friendship).not_to be_valid
    end
  end

  describe '#inverse' do
    subject { friendship.inverse }

    context 'when an inverse friendship exists' do
      before(:each) { inverse.save }

      it 'returns the inverse' do
        expect(subject).to eq(inverse)
      end
    end

    context 'when an inverse friendship does not exist' do
      it { is_expected.to be_nil }
    end
  end

  describe '#user' do
    it 'is required' do
      friendship.user = nil
      expect(friendship).not_to be_valid
    end
  end

  describe '.mutual' do
    let(:friendship) { create(:friendship) }
    subject(:mutual_ids) { described_class.mutual.ids }

    before(:each) do
      friendship
      inverse.save
      create(:friendship)
    end

    it 'returns all bidirectional friendships' do
      expect(mutual_ids).to contain_exactly(inverse.id, friendship.id)
    end
  end

  describe '.non_mutual' do
    let(:friendship) { create(:friendship) }
    let(:non_matching) { create(:friendship) }
    subject(:non_mutual_ids) { described_class.non_mutual.ids }

    before(:each) do
      friendship
      inverse.save
      non_matching
    end

    it 'returns all bidirectional friendships' do
      expect(non_mutual_ids).to contain_exactly(non_matching.id)
    end
  end
end
