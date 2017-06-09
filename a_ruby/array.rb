These applys to Enumerable and array
########## map ##########
ar.map(&:name)
ar.map{|x|x.name}

########## any?, all? ##########
It takes a block
The default block {|x|x} if no block provided
The block returns a bool 
