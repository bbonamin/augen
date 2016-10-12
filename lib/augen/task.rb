# frozen_string_literal: true
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
  end
end
