require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build_stubbed(:user) }

  describe '#provider' do
    it 'is required' do
      user.provider = nil
      expect(user).not_to be_valid
    end
  end

  describe '#uid' do
    it 'is required' do
      user.uid = nil
      expect(user).not_to be_valid
    end
  end

  describe '#full_name' do
    it 'is required' do
      user.full_name
    end
  end

  describe '#display_name' do
    it 'is required' do
      user.display_name = nil
      expect(user).not_to be_valid
    end
  end

  describe '.from_omniauth' do
    let(:auth) { build(:auth) }
    let(:user) { User.from_omniauth(auth) }

    it 'builds a user from an auth hash' do
      expect(user).to be_a(described_class)
    end

    it 'includes the email from the hash' do
      expect(user.email).to eq(auth[:info][:email])
    end

    it 'includes the name from the hash' do
      expect(user.full_name).to eq(auth[:info][:name])
    end

    it 'includes the display name from the hash' do
      expect(user.display_name).to eq(auth[:info][:nickname])
    end

    it 'includes the provider and UID from the hash' do
      [:provider, :uid].each do |field|
        expect(user.send(field)).to eq(auth[field])
      end
    end
  end
end
