# frozen_string_literal: true

require_relative 'errors/too_many_request_error'

module Trafficdog
  class SlideWindow
    def call
      current_timestamp = (Time.now.to_f * 1000).round
      begin_timestamp = current_timestamp - 1000

      request_ids = conn.zrangebyscore(key, begin_timestamp, current_timestamp)

      raise Trafficdog::Errors::TooManyRequestError if request_ids.size > limit

      conn.zadd(key, (Time.now.to_f * 1000).round, SecureRandom.uuid)

      expired_elements = redis.zrangebyscore(key, '-inf', begin_timestamp)
      conn.zrem(key, expired_elements)

      true
    end

    def conn
      Trafficdog.configuration.conn
    end

    def limit
      Trafficdog.configuration.incr_limit
    end

    def key
      Trafficdog.configuration.zset_key
    end
  end
end
