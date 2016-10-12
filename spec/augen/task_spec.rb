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
      type: 'AST',
      minimum_time: 120, # minutes
      turnpoints: [
        turnpoint_1,
        turnpoint_2
      ]
    )
  end

  it 'has a type reader' do
    expect(subject).to respond_to :type
    expect(subject.type).to eq 'AST'
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

  describe 'triangle AST task' do
    let(:turnpoint_2) do
      Augen::Turnpoint.new(
        type: :turnpoint,
        category: :turn_point_cylinder,
        length: 500,
        waypoint: Augen::Waypoint.new(
          name: 'Bombal',
          country: 'AR',
          latitude: '3327.500S',
          longitude: '06119.200W',
          elevation: '0.0m'
        )
      )
    end

    let(:turnpoint_3) do
      Augen::Turnpoint.new(
        type: :turnpoint,
        category: :turn_point_cylinder,
        length: 500,
        waypoint: Augen::Waypoint.new(
          name: 'Arrecifes',
          country: 'AR',
          latitude: '3403.800S',
          longitude: '06006.000W',
          elevation: '0.0m'
        )
      )
    end

    let(:turnpoint_4) do
      Augen::Turnpoint.new(
        type: :finish,
        category: :finish_cylinder,
        length: 3_000,
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

    subject do
      described_class.new(
        type: 'AST',
        minimum_time: 120, # minutes
        turnpoints: [
          turnpoint_1,
          turnpoint_2,
          turnpoint_3,
          turnpoint_4
        ]
      )
    end

    describe 'calculated attributes' do
      it 'has a nominal distance' do
        puts "NOMINAL DISTANCE #{subject.nominal_distance}"
        # within 1km
        expect(subject.nominal_distance).to be_within(1_000).of(351_000)
      end
      it 'has a minimum distance'
      it 'has a maximum distance'
    end
  end
end
