Short list (high to low precedence)
= &&  || or and  if 

a = false && true
b = false and true
c = true || false
d = true && false

def test1
  puts 'hello' && return
  puts 'world'
end

def test2
  puts 'hello' and return if true
  puts 'after return'
end

def test3
  @a = 1 and return
  puts 'after return'
end

#####  Reference #####
Ruby operators (high to low precedence)
Operator  Description 
[ ] [ ]=  Element reference, element set  
**  Exponentiation  
! ~ + - Not, complement, unary plus and minus (method names for the last two are +@ and -@) 
* / % Multiply, divide, and modulo  
+ - Plus and minus  
>> << Right and left shift  
& Bitwise `and' 
^ | Bitwise exclusive `or' and regular `or' 
<= < > >= Comparison operators  
<=> == === != =~ !~ Equality and pattern match operators (!= and !~ may not be defined as methods)  
&&  
||  
.. ...  Range (inclusive and exclusive) 
? : Ternary if-then-else  
= %= { /= -= += |= &= >>= <<= *= &&= ||= **=  Assignment  
defined?  Check if symbol defined 
not Logical negation  
or and  Logical composition 
if unless while until Expression modifiers  
begin/end   
