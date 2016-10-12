# frozen_string_literal: true
require 'haversine'

module Augen
  class Task
    attr_reader :type, :turnpoints, :minimum_time
    def initialize(opts = {})
      @type = opts.fetch(:type) { raise ArgumentError, 'type is needed' }

      @minimum_time = opts.fetch(:minimum_time) do
        raise ArgumentError, 'minimum_time is needed'
      end

      @turnpoints = opts.fetch(:turnpoints) do
        raise ArgumentError, 'turnpoints is needed'
      end
    end

    def nominal_distance
      turnpoints.each_with_index.inject(0) do |distance, (tp, index)|
        next_tp = turnpoints[index + 1]
        break distance if next_tp.nil?
        distance + distance_between(tp, next_tp)
      end - turnpoints.last.length # follow XCSoar convention
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
