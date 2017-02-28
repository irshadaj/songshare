require 'optparse'

module Dinodex
  class CLIParser
    VALID_FORMATS = [:list, :json].freeze

    def parse(*args)
      parse_arguments(args.dup)
    end

    private

    def help(parser)
      puts "#{parser}\n"
    end

    def parse_arguments(args)
      options = { format: :list }

      parser = OptionParser.new do |p|
        p.banner = 'Usage: cli.rb [options] <file>...'
        p.separator("\nFilters:")

        p.on('-b', '--big', 'Include only big dinosaurs') do
          options[:big] = true
        end

        p.on('--bipedal', 'Include only bipedal dinosaurs') do
          options[:bipedal] = true
        end

        p.on('--carnivores', 'Include only carnivores') do
          options[:carnivore] = true
        end

        p.on('-d DIET', '--diet=DIET', 'Include only dinosaurs with the given diet', String) do |diet|
          options[:diet] = diet
        end

        p.on('--herbivores', 'Include only herbivores') do
          options[:herbivore] = true
        end

        p.on('--max-weight=WEIGHT', 'Include only dinosaurs no heavier than WEIGHT', Float) do |weight|
          options[:max_weight] = weight
        end

        p.on('--min-weight=WEIGHT', 'Include only dinosaurs no lighter than WEIGHT', Float) do |weight|
          options[:min_weight] = weight
        end

        p.on('-n NAME', '--name=NAME', 'Include only dinosaurs whose name contains NAME', String) do |name|
          options[:name] = name
        end

        p.on('-p PERIOD', '--period=PERIOD', 'Include only dinosaurs from the given period', String) do |period|
          options[:period] = period
        end

        p.on('-s', '--small', 'Include only small dinosaurs') do
          options[:small] = true
        end

        p.separator("\nOutput options:")

        p.on('-f', '--format=FORMAT', 'Output results as FORMAT (list | json) [default: list]', VALID_FORMATS) do |format|
          options[:format] = format
        end

        p.on('-o FILENAME', '--output=FILENAME', 'Output results to file at path FILENAME instead of STDOUT', String) do |filename|
          options[:output_file] = filename
        end

        p.separator("\nMiscellaneous options:")

        p.on('-h', '--help', 'Show this help message') do
          help(p)
        end
      end

      return help(parser) if args.empty?
      parser.parse!(args)

      options[:input_files] = args
      options
    rescue OptionParser::InvalidArgument => e
      STDERR.puts "Invalid argument(s): #{e.args.join(', ')}"
    rescue OptionParser::InvalidOption => e
      STDERR.puts "Invalid option(s): #{e.args.join(', ')}"
    rescue OptionParser::MissingArgument => e
      STDERR.puts "Missing argument(s): #{e.args.join(', ')}"
    end
  end
end
