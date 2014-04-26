module Rankable
  def get_pageviews
    redis = Redis.get_connection
    p = redis.get_pageviews(self.class.to_s, slug)

    if p < pageviews
      # copiaremos o valor persistido no mongo para o redis
      redis.set_value(self.class.to_s, pageviews, slug)
      p = pageviews
    end
    p
  end

  def increment_pageviews
    redis = Redis.get_connection
    redis.increment_pageview(self.class.to_s, slug)
  end
end
