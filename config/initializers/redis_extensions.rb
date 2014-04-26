class Redis
  def self.get_connection
    # Por enquanto será utilizado apenas no localhost
    unless defined? @@connection
      @@connection = Redis.new(:host => "localhost", 
                               :port => 6379)
    end
    @@connection
  end

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
