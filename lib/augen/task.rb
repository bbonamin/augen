# frozen_string_literal: true
require 'haversine'

module Augen
  class Task
    VALID_TYPES = %w(AAT AST).freeze
    attr_reader :type, :turnpoints, :minimum_time

    def initialize(opts = {})
      type = opts[:type] || raise(ArgumentError, 'type is needed')
      raise(ArgumentError, 'invalid task type') unless VALID_TYPES.include?(type)
      @type = type

      if @type == 'AAT'
        @minimum_time = opts[:minimum_time] || raise(ArgumentError, 'minimum_time is needed for AAT tasks')
      end

      @turnpoints = opts[:turnpoints] || raise(ArgumentError, 'turnpoints is needed')
    end

    def nominal_distance
      turnpoints.each_with_index.inject(0) do |distance, (tp, index)|
        next_tp = turnpoints[index + 1]
        break distance if next_tp.nil?
        distance + distance_between(tp, next_tp)
      end - turnpoints.last.length # follow XCSoar convention
    end

    def minimum_distance
      return nominal_distance if @type == 'AST'
    end

    def maximum_distance
      return nominal_distance if @type == 'AST'
    end

    private

    def distance_between(tp, other)
      Haversine.distance(
        [tp.latitude_dd, tp.longitude_dd],
        [other.latitude_dd, other.longitude_dd]
      ).to_meters
    end
  end
end
