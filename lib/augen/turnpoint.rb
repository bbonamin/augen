# frozen_string_literal: true
module Augen
  class Turnpoint
    extend Forwardable
    def_delegators :waypoint, :latitude_dd, :longitude_dd
    attr_reader :type, :category, :length, :waypoint
    VALID_TYPES = %i(start turnpoint finish).freeze
    VALID_CATEGORIES = %i(
      start_line
      turn_point_cylinder
      area_cylinder
      finish_cylinder
    ).freeze

    def initialize(opts = {})
      init_type opts[:type]
      init_category opts[:category]

      @length = opts[:length] || raise(ArgumentError, 'length is needed')
      @waypoint = opts[:waypoint] || raise(ArgumentError, 'waypoint is needed')
    end

    private

    def init_type(type)
      raise(ArgumentError, 'type is needed') if type.nil?
      raise ArgumentError, 'invalid type' unless VALID_TYPES.include?(type)
      @type = type
    end

    def init_category(category)
      raise(ArgumentError, 'category is needed') if category.nil?
      raise ArgumentError, 'invalid category' \
        unless VALID_CATEGORIES.include?(category)
      @category = category
    end
  end
end
