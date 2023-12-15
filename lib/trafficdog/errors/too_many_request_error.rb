# frozen_string_literal: true

require_relative 'base_error'

module Trafficdog
  module Errors
    class TooManyRequestError < BaseError
      def initialize(msg = 'Too many requests')
        super(msg)
      end
    end
  end
end
