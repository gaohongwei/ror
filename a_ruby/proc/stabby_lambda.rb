proc = ->(arg) { puts arg }
proc.call "abc"
proc['abc']

> proc.call "now",'111'
ArgumentError: wrong number of arguments (2 for 1)
