##### Capture match #####
string = "RyanOnRails: This is a test"
string =~ /(^.*)(:)(.*)/
string.match(/(^.*)(:)(.*)/i)

if match = string.match(/(^.*)(:)(.*)/i)
  one, two, three = match.captures
end

if ryan_string =~ /(^.*)(:)(.*)/i
   first, third = $1,$3
end

one, two, three = Regexp.last_match.captures
##### Regular expression with variable name #####
2. Interpolating a string into a regex
uid='1234'
test = ["1234_o365" , "1000"]
test.find{|x| /#{uid}/ =~ x}

if goo =~ /#{Regexp.quote(uid)}/
  
##### Regular expression with variable name #####
s="link_to 'New Part', new_part_path"
s.sub(/link_to (.*),(.*)/,'\1\2')
s.sub(/link_to (.*),(.*)/,'t(\1),\2')
s.sub(/link_to (.*),(.*)/,'link_to t(\1),\2')

ps={pold:"link_to (.*),(.*)",pnew:"link_to t(\\1),\\2"}
s.sub(/#{ps[:pold]}/, "#{ps[:pnew]}")

###  .*,  Agressive
###  .*?, Non-Agressive
