begin  

rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
  puts "\nError:"
  puts e.to_s
  exit 1
end
