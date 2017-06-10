string = "RyanOnRails: This is a test"
string =~ /(^.*)(:)(.*)/
string.match(/(^.*)(:)(.*)/i)

if match = string.match(/(^.*)(:)(.*)/i)
  one, two, three = match.captures
end

if ryan_string =~ /(^.*)(:)(.*)/i
   first = $1
   third = $3
end

one, two, three = Regexp.last_match.captures
