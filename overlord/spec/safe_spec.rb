require_relative 'spec_helper'

RSpec.describe Safe do
  let(:safe) { described_class.new }

  describe '#initialize' do
    it 'defaults the max number of failed attempts to 3' do
      expect(safe.max_attempts).to eq(3)
    end

    it 'accepts a custom number of failed attempts' do
      safe = described_class.new(5)
      expect(safe.max_attempts).to eq(5)
    end

    it 'is unlocked' do
      expect(safe).not_to be_locked
    end
  end

  describe '#lock' do
    context 'when unlocked' do
      context 'and no combination is provided' do
        subject(:lock) { safe.lock }

        it 'locks the safe' do
          lock
          expect(safe).to be_locked
        end

        it 'sets the number of remaining attempts to the max' do
          lock
          expect(safe.remaining_attempts).to eq(safe.max_attempts)
        end
      end

      context 'and a valid combination is provided' do
        subject(:lock) { safe.lock('4433') }

        it 'locks the safe' do
          lock
          expect(safe).to be_locked
        end

        it 'sets the number of remaining attempts to the max' do
          lock
          expect(safe.remaining_attempts).to eq(safe.max_attempts)
        end
      end

      context 'and combination is invalid' do
        let(:invalid_combinations) { %w(43D8 552 93288) }

        it 'raises an argument error' do
          invalid_combinations.each do |combination|
            expect { safe.lock(combination) }.to raise_error(ArgumentError)
          end
        end

        it 'does not lock the safe' do
          invalid_combinations.each do |combination|
            begin
              safe.lock(combination)
            rescue ArgumentError
              expect(safe).not_to be_locked
            end
          end
        end
      end
    end

    context 'when locked' do
      before(:each) { safe.lock }

      it 'raises an incorrect state error' do
        expect { safe.lock }.to raise_error(IncorrectStateError)
      end
    end
  end

  describe '#unlock' do
    context 'when no combination provided' do
      it 'raises an argument error' do
        expect { safe.unlock }.to raise_error(ArgumentError)
      end
    end

    context 'when unlocked' do
      it 'raises an incorrect state error' do
        expect { safe.unlock('1234') }.to raise_error(IncorrectStateError)
      end
    end

    context 'when locked with default combination' do
      let(:combination) { '1234' }
      before(:each) { safe.lock }

      context 'and correct combination is provided' do
        subject(:unlock) { safe.unlock(combination) }

        it { is_expected.to be_truthy }

        it 'unlocks the safe' do
          unlock
          expect(safe).not_to be_locked
        end
      end

      context 'and incorrect combination is provided' do
        context 'up to three times' do
          it 'is falsey' do
            3.times { expect(safe.unlock('5555')).to be_falsey }
          end

          it 'does not unlock the safe' do
            3.times do
              safe.unlock('5555')
              expect(safe).to be_locked
            end
          end

          it 'decrements the number of remaining attempts' do
            safe.unlock('5555')
            expect(safe.remaining_attempts).to eq(2)
            safe.unlock('3425')
            expect(safe.remaining_attempts).to eq(1)
            safe.unlock('7623')
            expect(safe.remaining_attempts).to eq(0)
          end
        end
      end

      context 'when relocker is enabled' do
        before(:each) { 3.times { safe.unlock('5555') }}

        it 'raises an incorrect state error' do
          expect { safe.unlock('1234') }.to raise_error(IncorrectStateError)
        end
      end
    end

    context 'when locked with custom combination' do
      let(:combination) { '3322' }
      before(:each) { safe.lock(combination) }

      context 'and correct combination is provided' do
        subject(:unlock) { safe.unlock(combination) }

        it { is_expected.to be_truthy }

        it 'unlocks the safe' do
          unlock
          expect(safe).not_to be_locked
        end
      end

      context 'and incorrect combination is provided' do
        context 'up to three times' do
          it 'is falsey' do
            3.times { expect(safe.unlock('5555')).to be_falsey }
          end

          it 'does not unlock the safe' do
            3.times do
              safe.unlock('5555')
              expect(safe).to be_locked
            end
          end

          it 'decrements the number of remaining attempts' do
            safe.unlock('5555')
            expect(safe.remaining_attempts).to eq(2)
            safe.unlock('3425')
            expect(safe.remaining_attempts).to eq(1)
            safe.unlock('7623')
            expect(safe.remaining_attempts).to eq(0)
          end
        end
      end

      context 'when relocker is enabled' do
        before(:each) { 3.times { safe.unlock('5555') }}

        it 'raises an incorrect state error' do
          expect { safe.unlock('1234') }.to raise_error(IncorrectStateError)
        end
      end
    end
  end

  describe '#state' do
    subject(:state) { safe.state }

    context 'when relocked' do
      before(:each) do
        safe.lock
        3.times { safe.unlock('5555') }
      end

      it { is_expected.to eq(:relocked) }
    end

    context 'when unlocked' do
      it { is_expected.to eq(:unlocked) }
    end

    context 'when locked' do
      before(:each) { safe.lock }

      it { is_expected.to eq(:locked) }
    end
  end
end
