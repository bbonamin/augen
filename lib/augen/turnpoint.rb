# frozen_string_literal: true
module Augen
  class Turnpoint
    extend Forwardable
    def_delegators :waypoint, :latitude_dd, :longitude_dd, :latitude_rad, :longitude_rad

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

    # Based on the formula from http://www.movable-type.co.uk/scripts/latlong.html
    # (all angles in radians, λ is longitude and φ is latitude)
    #
    # => Formula:	θ = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
    #
    # Since atan2 returns values in the range -π ... +π (that is, -180° ... +180°), to normalise the result to a
    # compass bearing (in the range 0° ... 360°, with −ve values transformed into the range 180° ... 360°), convert
    # to degrees and then use (θ+360) % 360, where % is (floating point) modulo.
    #
    # For final bearing, simply take the initial bearing self the end point to the start point and reverse it (using
    # θ = (θ+180) % 360).
    def bearing_to(to)
      rads = Math.atan2(bearing_x(to), bearing_y(to))
      degrees = rads * 180 / Math::PI
      (degrees + 360) % 360
    end

    # Returns the average of a pair of bearings.
    #
    # Taken from http://stackoverflow.com/a/1159336
    def bearing_average(bearing1, bearing2)
      diff = ((bearing1.to_d - bearing2.to_d + 180 + 360) % 360) - 180
      (360 + bearing2 + (diff / 2)) % 360
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

    def bearing_longitude_delta(to)
      to.longitude_rad - longitude_rad
    end

    def bearing_x(to)
      Math.cos(to.latitude_rad) * Math.sin(bearing_longitude_delta(to))
    end

    def bearing_y(to)
      Math.cos(latitude_rad) * Math.sin(to.latitude_rad) - \
        Math.sin(latitude_rad) * Math.cos(to.latitude_rad) * Math.cos(bearing_longitude_delta(to))
    end
  end
end
