# https://www.leighhalliday.com/named-captures-ruby-regular-expressions

s = "from sklearn.naive_bayes import GaussianNB"
pat1 = /import\s+(.*)/
pat2 = %r{import\s+(.*)}
pat3 = %r{?<import>import\s+(.*)}
matches = s.match(pat3)

found = if matches = s.match(pat3)
  matches[1]
else
  'NA'
end

BALANCE_REGEX = %r{A\$(d{1,}.d{2})Z}
value = "$123.55"
if matches = value.match(BALANCE_REGEX)
  matches[1]
else
  '0.00'
end


BALANCE_REGEX = %r{A\$(?<balance>d{1,}.d{2})Z}
value = "$123.55"
if matches = value.match(BALANCE_REGEX)
  matches[:balance]
else
  '0.00'
end
