# frozen_string_literal: true

require 'redis'
require 'securerandom'

require_relative 'trafficdog/version'
require_relative 'trafficdog/configuration'
require_relative 'trafficdog/fixed_window'
require_relative 'trafficdog/slide_window'
require_relative 'trafficdog/errors/invalid_strategy_error'

module Trafficdog
  class << self
    def version
      VERSION
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def setup
      yield(configuration) if block_given?
      nil
    end

    def call
      case configuration.strategy
      when :fixed_window
        FixedWindow.new.call
      when :slide_window
        SlideWindow.new.call
      else
        raise Trafficdog::Errors::InvalidStrategyError
      end
    end
  end
end
