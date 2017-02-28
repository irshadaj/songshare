require_relative '../spec_helper'

RSpec.describe Dinodex::CLIParser do
  let(:parser) { described_class.new }

  describe '#parse' do
    shared_examples 'displays help message' do |argument_sets|
      it 'outputs the help message' do
        argument_sets.each do |args|
          expect { parser.parse(*args) }.to output(/Usage: cli\.rb/).to_stdout
        end
      end
    end

    context 'without options' do
      include_examples 'displays help message', [[]]
    end

    context 'with invalid options' do
      it 'displays an error' do
        expect { parser.parse('-g') }.to output(/Invalid option\(s\): -g/).to_stderr_from_any_process
      end
    end

    describe 'flags:' do
      describe '-b, --big' do
        it 'enables big filter' do
          expect(parser.parse('-b')[:big]).to be true
          expect(parser.parse('--big')[:big]).to be true
        end
      end

      describe '--bipedal' do
        it 'enables bipedal filter' do
          expect(parser.parse('--bipedal')[:bipedal]).to be true
        end
      end

      describe '--carnivores' do
        it 'enables carnivore filter' do
          expect(parser.parse('--carnivores')[:carnivore]).to be true
        end
      end

      describe '-d, --diet' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('-d') }.to output(/Missing argument\(s\): -d/).to_stderr_from_any_process
            expect { parser.parse('--diet') }.to output(/Missing argument\(s\): --diet/).to_stderr_from_any_process
          end
        end

        context 'with a diet value' do
          let(:value) { 'Carnivore' }

          it 'sets diet filter to the provided value' do
            expect(parser.parse('-d', value)[:diet]).to eq(value)
            expect(parser.parse("--diet=#{value}")[:diet]).to eq(value)
          end
        end
      end

      describe '-f, --format' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('-f') }.to output(/Missing argument\(s\): -f/).to_stderr_from_any_process
            expect { parser.parse('--format') }.to output(/Missing argument\(s\): --format/).to_stderr_from_any_process
          end
        end

        context 'with a valid format value' do
          it 'sets the format option to the provided value' do
            [:list, :json].each do |format|
              expect(parser.parse('-f', format.to_s)[:format]).to eq(format)
              expect(parser.parse("--format=#{format}")[:format]).to eq(format)
            end
          end
        end

        context 'with an invalid format value' do
          it 'displays an invalid argument error message' do
            [:bad, :invalid, :misc].each do |value|
              expect { parser.parse('-f', value.to_s) }.to output(/Invalid argument\(s\): -f, #{value}/).
                to_stderr_from_any_process
              expect { parser.parse("-format=#{value}") }.to output(/Invalid argument\(s\): -format=#{value}/).
                to_stderr_from_any_process
            end
          end
        end
      end

      describe '-h, --help' do
        include_examples 'displays help message', [['-h'], ['--help']]
      end

      describe '--herbivores' do
        it 'enables herbivore filter' do
          expect(parser.parse('--herbivore')[:herbivore]).to be true
        end
      end

      describe '--max-weight' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('--max-weight') }.to output(/Missing argument\(s\): --max-weight/).to_stderr_from_any_process
          end
        end

        context 'with a numeric value' do
          let(:value) { 31.5 }

          it 'sets max weight filter to the value' do
            expect(parser.parse("--max-weight=#{value}")[:max_weight]).to eq(value)
          end
        end

        context 'with a non-numeric value' do
          let(:value) { 'Dog' }

          it 'displays an invalid argument error message' do
            expect { parser.parse("--max-weight=Dog") }.to output(/Invalid argument\(s\): --max-weight=Dog/).
              to_stderr_from_any_process
          end
        end
      end

      describe '--min-weight' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('--min-weight') }.to output(/Missing argument\(s\): --min-weight/).to_stderr_from_any_process
          end
        end

        context 'with a numeric value' do
          let(:value) { 31.5 }

          it 'sets min weight filter to the value' do
            expect(parser.parse("--min-weight=#{value}")[:min_weight]).to eq(value)
          end
        end

        context 'with a non-numeric value' do
          let(:value) { 'Dog' }

          it 'displays an invalid argument error message' do
            expect { parser.parse("--min-weight=Dog") }.to output(/Invalid argument\(s\): --min-weight=Dog/).
              to_stderr_from_any_process
          end
        end
      end

      describe '-n, --name' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('-n') }.to output(/Missing argument\(s\): -n/).to_stderr_from_any_process
            expect { parser.parse('--name') }.to output(/Missing argument\(s\): --name/).to_stderr_from_any_process
          end
        end

        context 'with value' do
          let(:name) { 'Dino' }

          it 'sets name filter to the value' do
            expect(parser.parse('-n', name)[:name]).to eq(name)
            expect(parser.parse("--name=#{name}")[:name]).to eq(name)
          end
        end
      end

      describe '-o, --output' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('-o') }.to output(/Missing argument\(s\): -o/).to_stderr_from_any_process
            expect { parser.parse('--output') }.to output(/Missing argument\(s\): --output/).to_stderr_from_any_process
          end
        end

        context 'with value' do
          let(:filename) { '/tmp/file' }

          it 'sets the output filename to the provided value' do
            expect(parser.parse('-o', filename)[:output_file]).to eq(filename)
            expect(parser.parse("--output=#{filename}")[:output_file]).to eq(filename)
          end
        end
      end

      describe '-p, --period' do
        context 'with no value' do
          it 'displays a missing argument error message' do
            expect { parser.parse('-p') }.to output(/Missing argument\(s\): -p/).to_stderr_from_any_process
            expect { parser.parse('--period') }.to output(/Missing argument\(s\): --period/).to_stderr_from_any_process
          end
        end

        context 'with value' do
          let(:period) { 'Cretaceous' }

          it 'sets period filter to the value' do
            expect(parser.parse('-p', period)[:period]).to eq(period)
            expect(parser.parse("--period=#{period}")[:period]).to eq(period)
          end
        end
      end

      describe '-s, --small' do
        it 'enables big filter' do
          expect(parser.parse('-s')[:small]).to be true
          expect(parser.parse('--small')[:small]).to be true
        end
      end
    end

    it 'accepts multiple flags' do
      options = parser.parse('-s', '--carnivores', '--name=Dino')
      expect(options[:small]).to be true
      expect(options[:carnivore]).to be true
      expect(options[:name]).to eq('Dino')
      expect(options[:big]).not_to be true
    end

    it 'sets leftover arguments as the input files' do
      options = parser.parse('-s', '--carnivore', '/tmp/input', '/tmp/input2')
      expect(options[:input_files]).to contain_exactly('/tmp/input', '/tmp/input2')
    end
  end
end
