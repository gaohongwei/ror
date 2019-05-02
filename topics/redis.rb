
> type *
> type <key>
for "string": get <key>
for "hash": hgetall <key>
for "list": lrange <key> 0 -1
for "set": smembers <key>
for "zset": zrange <key> 0 -1 withscores

type queue:high
lrange queue:high -1 0
lrange k1 0 0
