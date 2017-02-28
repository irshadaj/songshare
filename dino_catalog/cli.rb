#!/usr/bin/env ruby

require_relative 'lib/dinodex'

parser = Dinodex::CLIParser.new
options = parser.parse(*ARGV)

# your code here

puts options
