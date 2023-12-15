# frozen_string_literal: true

module Trafficdog
  class Configuration
    attr_writer :url, :conn, :incr_key, :zset_key, :incr_limit, :strategy

    def url
      @url ||= 'redis://127.0.0.1:6379/1'
    end

    def conn
      @conn ||= Redis.new(url: url)
    end

    def incr_key
      @incr_key ||= 'trafficdog_incr_key'
    end

    def zset_key
      @zset_key ||= 'trafficdog_zset_key'
    end

    def incr_limit
      @incr_limit ||= 100
    end

    def strategy
      @strategy ||= :fixed_window
    end
  end
end
