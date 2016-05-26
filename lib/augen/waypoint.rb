# frozen_string_literal: true
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
  end
end
