# frozen_string_literal: true
require 'bigdecimal'
require 'bigdecimal/util'

module Augen
  class Waypoint
    attr_reader :name, :code, :country, :latitude, :longitude, :elevation

    def initialize(opts = {})
      @name = opts[:name]
      @code = opts[:code]
      @country = opts[:country]
      @latitude = opts[:latitude] || raise(ArgumentError, 'latitude is needed')
      @longitude = opts[:longitude] ||
                   raise(ArgumentError, 'longitude is needed')
      @elevation = opts[:elevation]
    end

    # Waypoints by default follow the Degree Decimal Minute format, just as the
    # SeeYou CUP file format.
    #
    # In order to do various GIS calculations, latitude is needed in Decimal
    # Degree format.
    def latitude_dd
      bits = latitude.split('')
      degrees = bits[0..1].join.to_i
      decimal_minutes = bits[2..7].join.to_d
      hemisphere_to_sign(bits[8]) * (degrees + (decimal_minutes / 60)
                                    ).truncate(6)
    end

    def latitude_rad
      (latitude_dd / 180) * Math::PI
    end

    # Waypoints by default follow the Degree Decimal Minute format, just as the
    # SeeYou CUP file format.
    #
    # In order to do various GIS calculations, longitude is needed in Decimal
    # Degree format.
    def longitude_dd
      bits = longitude.split('')
      degrees = bits[0..2].join.to_i
      decimal_minutes = bits[3..8].join.to_d
      hemisphere_to_sign(bits[9]) * (degrees + (decimal_minutes / 60)
                                    ).truncate(6)
    end

    def longitude_rad
      (longitude_dd * Math::PI) / 180
    end

    private

    def hemisphere_to_sign(hemisphere)
      hemisphere.upcase!
      return +1 if %w(N E).include? hemisphere
      return -1 if %w(S W).include? hemisphere
      raise ArgumentError, "#{hemisphere} is not a valid hemisphere."
    end
  end
end
