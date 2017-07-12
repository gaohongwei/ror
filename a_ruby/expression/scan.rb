scan find all
match find the first

s = '1011001110001111'
matched = s.scan(/0+/)
matched = s.scan(/1+/)

How to use negative expression?
matched = s.scan(/[^0]+/)
