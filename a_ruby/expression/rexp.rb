A regular expression literal is a pattern between slashes or
between arbitrary delimiters followed by %r
s =~ /abc/
s =~ %r(abc)
s =~ %r|abc|

%r{... } : (/... /)
expect(rendered).to match %r{<tr><td></td></tr>}

##### Regular expression constant #####
PATTERN = /[a-zA-Z0-9]/
s =~ PATTERN
if s.match(PATTERN)
  
##### Regular expression with variable name #####
var='food'
s =~ /^#{var}$/
if s =~/^#{var}$/ 
#######################################
## Add id according to class name
#file_names = ['foo.txt', 'bar.txt']
file_names=Dir.glob("template/*.html")
file_names.each do |file_name|
  text = File.read(file_name)
  #puts text.gsub(/search_regexp/, "replace string")
  #<div class="xtab scan_tab tab_btn" onclick="doAction('scan', null);">
  t=text.gsub(/<div class=\"xtab (.*?) (.*?)\"/,'<div id="\1" class="xtab \1 \2"')
  #puts "id=" + $1 unless $1.nil?
  puts t
  if text != t 
    puts file_name
  File.open(file_name, "w") {|file| file.puts t}
  end
end
##################
module KeywordValidator
  validate :validate_keywords  
  PATTERN = '\A[a-zA-Z0-9\-\_\n]+\z'
  MESSAGE = 'Only letters, numbers, dash (-), underscore (_) allowed.'
  REGX = Regexp.new(PATTERN)
  def keyword_list=(list)
    self.keywords = split_string(list)
  end

  def keyword_list
    keywords.join("\n") if keywords
  end

  def validate_keywords
    return if keywords.empty?
    return unless keywords.any? { |x| x !~ REGX }
    errors.add(:keyword_list, MESSAGE)
  end

  def split_string(list)
    list.split(
      /\s*[,;]\s* # comma or semicolon, optionally surrounded by whitespace
      |         # or
      \s{2,}    # two or more whitespace characters
      |         # or
      [\r\n]+   # any number of newline characters
      /x).map(&:strip)
  end
end
##################
Regular Expression Basic
Anchor
  ^: line header
  $: line tailer
  \A: string header
  \z: string tailer (no new line)
  \Z: string tailer

Pattern:
  /./ - Any character except a newline.
  /./m - Any character (the m modifier enables multiline mode)
  /\d/: A digit character ([0-9])
  /\D/: 
  /\w/: A word character ([a-zA-Z0-9_])
  /\W/: non word char, [^a-zA-Z0-9]+
  /\s/: A whitespace character: /[ \t\r\n\f]/
  /\S/:
  /\h/: hex
  /\H/:

Repetition
*: >=0
+: >=1
?: 0/1
{n}: Exactly n times
{n,}: n or more times
{,m}: m or less times
{n,m}: At least n and at most m times
