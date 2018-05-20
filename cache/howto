http://guides.rubyonrails.org/caching_with_rails.html#activesupport-cache-rediscachestore
1. Rails.cache.fetch, read/write cache
  class Product < ApplicationRecord
    def competing_price
      Rails.cache.fetch("#{cache_key}/competing_price", expires_in: 12.hours) do
        Competitor::API.find_price(id)
      end
    end
  end

2. Cache store config
config.cache_store = :null_store # development, test
config.cache_store = :memory_store, { size: 64.megabytes }
config.cache_store = :file_store, "/path/to/cache/directory"
config.cache_store = :file_store, {expires_in: 30.minutes}
config.cache_store = :redis_cache_store, { url: ENV['REDIS_URL'] }

config.cache_store = :redis_store, redis_config
  redis_config = { 
    host: 'localhost',
    port: 6379,
    db: 0, # retry
    namespace: 'prod-cache',
    expires_in: 180.minutes
  }
