#!/usr/bin/env ruby
require 'optparse'

OPTIONS = {
  file: { sym: '-f', name:  'file name', text: 'backup file list' },
  src: { sym: '-s', name:  'source dir', text: 'source dir' },
  dst: { sym: '-t', name:  'dest dir', text: 'dest dir' }
}

def normalize(options)
  # options[:file] ||= './backup.yml'
  # options[:header] ||= 'off'
  # options[:sort] ||= 'asc'
  # options[:pivot] ||= 'median'
  # options[:header] = %w(on yes).include?(options[:header].downcase)
  # options[:asc] = %w(asc).include?(options[:sort].downcase)
  # options[:pivot] = options[:pivot].downcase
  # options
end


options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "\nUsage: backup [Arguments]"
  opt.separator  ""
  opt.separator  "Arguments:"


  OPTIONS.each do|key, option|
    arg1 = option[:sym]
    arg2 = "--#{key} #{option[:name]}"
    #pt.on("-f","--file file name","The input file name, required")
    opt.on(arg1, arg2, option[:text]) do |value|
      options[key] = value
    end
  end

  opt.on("-h","--help","help") do
    puts opt_parser
    exit 0
  end
end

begin

  opt_parser.parse!
  if options.empty?
    puts opt_parser
    exit 0
  end
  if options[:src].nil? || options[:dst].nil?
    puts "\nError: \nSource or Dest not defined"
    puts opt_parser
    exit 1
  end
  puts "Run it now"
  pp options
rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
  puts "\nError:"
  puts e.to_s
  puts opt_parser
  exit 1
end
