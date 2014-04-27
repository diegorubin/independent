module RedisConnectionExtensions
  def get_connection
    unless defined? @@connection
      configfile = File.join([Rails.root.to_s, 'config', 'redis.yml'])
      config = YAML::load(File.read(configfile))
      @@connection = Redis.new(config[Rails.env])
    end
    @@connection
  end
end

module RedisExtensions
  def increment_pageview(set, identifier)
    Redis.get_connection.zincrby(set, 1, identifier)
  end

  def get_pageviews(set, identifier)
    Redis.get_connection.zscore(set, identifier).to_i || 0
  end

  def set_value(set, value, identifier)
    Redis.get_connection.zadd(set,value,identifier)
  end
end

Redis.send(:include, RedisExtensions)
Redis.send(:extend, RedisConnectionExtensions)

