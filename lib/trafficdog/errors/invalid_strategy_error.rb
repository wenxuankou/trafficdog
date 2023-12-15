# frozen_string_literal: true

require_relative 'base_error'

module Trafficdog
  module Errors
    class InvalidStrategyError < BaseError
      def initialize(msg = 'Invalid strategy')
        super(msg)
      end
    end
  end
end
