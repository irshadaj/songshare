require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  let(:recommendation) { build_stubbed(:recommendation) }

  describe '#to' do
    it 'is required' do
  	  recommendation.to = nil
  	  expect(recommendation).not_to be_valid
    end
  end

  describe '#from' do
  	it 'is required' do
  	  recommendation.from = nil
  	  expect(recommendation).not_to be_valid
  	end
  end

  describe '#updated_at' do
  	it 'is required' do
  	  recommendation.updated_at = nil
  	  expect(recommendation).not_to be_valid
  	end
  end

  describe '#created_at' do
  	it 'is required' do
  	  recommendation.created_at = nil
  	  expect(recommendation).not_to be_valid
  	end
  end

  describe '#song_uri' do
  	it 'is required' do
  	  recommendation.song_uri = nil
  	  expect(recommendation).not_to be_valid
  	end
  end

  describe '#song_title' do
  	it 'is required' do
  	  recommendation.song_title = nil
  	  expect(recommendation).not_to be_valid
  	end
  end
end
