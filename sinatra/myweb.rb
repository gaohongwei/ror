# myweb.rb
require 'sinatra'
require 'json'

get '/' do
  'Hello world!'
end

get '/api' do
  data = {
    status: 'success',
    'bootstrap.servers' => 'localhost:9092',
    'group.id' => 'test',
    'enable.auto.commit' => true,
    'key.deserializer' => 'org.apache.kafka.common.serialization.StringDeserializer',
    'value.deserializer' => 'org.apache.kafka.common.serialization.StringDeserializer',
    # fast session timeout makes it more fun to play with failover
    'session.timeout.ms' => 10000,
    # These buffer sizes seem to be needed to avoid consumer switching to
    # a mode where it processes one bufferful every 5 seconds with multiple
    # timeouts along the way.  No idea why this happens.
    'fetch.min.bytes' => 50000,
    'receive.buffer.bytes' => 262144,
    'max.partition.fetch.bytes' => 2097152
  }
  status 200
  data.to_json
end
