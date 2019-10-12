Nginx: 
  Load balance

Dyno:
  one bigger vs several small ones

Requests buffer
  Some request may take long time
  Buffer requests into middleware
    kafka
    message queue
    jobq

Cache:
  data:
    Find repreated used data
  Page Caching
  action Caching
  fragment Caching

Database
  Read
    pre-compute table
      summary table
    cache

  DB write slow 
    combine tx
    batch commit
    delayed job

  Insert slow
    add MD5 hash id of uniq data
    dont use auto id
    auto id has a limitation of 2b rows
    int 2,147,483,647, 2b

  database
    write to master db
    read from slave
    run deplayed jon on dedicated instances 

Move to micro-services
