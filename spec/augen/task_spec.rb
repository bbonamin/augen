# frozen_string_literal: true
require 'augen/waypoint'
require 'augen/turnpoint'
require 'augen/task'

RSpec.describe Augen::Task do
  let(:turnpoint_1) do
    Augen::Turnpoint.new(
      type: :start,
      category: :start_line,
      length: 10_000,
      waypoint: Augen::Waypoint.new(
        name: 'Rosario Apt',
        code: 'SAAR',
        country: 'AR',
        latitude: '3254.150S',
        longitude: '06047.117W',
        elevation: '0.0m'
      )
    )
  end
  let(:turnpoint_2) do
    Augen::Turnpoint.new(
      type: :finish,
      category: :finish_cylinder,
      length: 1_000,
      waypoint: Augen::Waypoint.new(
        name: 'Arrecifes',
        country: 'AR',
        latitude: '3403.800S',
        longitude: '06006.000W',
        elevation: '0.0m'
      )
    )
  end

  subject do
    described_class.new(
      type: 'AAT',
      minimum_time: 120, # minutes
      turnpoints: [
        turnpoint_1,
        turnpoint_2
      ]
    )
  end

  it 'has a type reader' do
    expect(subject).to respond_to :type
    expect(subject.type).to eq 'AAT'
  end

  it 'has a minimum time reader' do
    expect(subject).to respond_to :minimum_time
    expect(subject.minimum_time).to eq(120)
  end

  describe 'calculated attributes' do
    it 'has a nominal distance' do
      # within 1km
      expect(subject.nominal_distance).to be_within(1_000).of(143_000)
    end
    it 'has a minimum distance'
    it 'has a maximum distance'
  end
end
