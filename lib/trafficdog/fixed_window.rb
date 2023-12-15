# frozen_string_literal: true

require_relative 'errors/too_many_request_error'

module Trafficdog
  class FixedWindow
    def call
      no = conn.incr(key)

      conn.expire(key, 1) if no == 1

      raise Trafficdog::Errors::TooManyRequestError if no > limit

      true
    end

    def conn
      Trafficdog.configuration.conn
    end

    def key
      Trafficdog.configuration.incr_key
    end

    def limit
      Trafficdog.configuration.incr_limit
    end
  end
end
