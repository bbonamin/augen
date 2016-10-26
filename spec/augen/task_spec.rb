# frozen_string_literal: true
require 'augen/waypoint'
require 'augen/turnpoint'
require 'augen/task'

RSpec.describe Augen::Task do
  let(:turnpoints) { [] }

  subject do
    described_class.new(
      type: 'AST',
      turnpoints: turnpoints
    )
  end

  it 'accepts AAT as a type' do
    expect { described_class.new(type: 'AAT', minimum_time: 1, turnpoints: []) }.not_to raise_error
  end

  it 'accepts AST as a type' do
    expect { described_class.new(type: 'AST', turnpoints: []) }.not_to raise_error
  end

  it 'does not accept random strings as a type' do
    expect do
      described_class.new(type: 'foobar', turnpoints: [])
    end.to raise_error(ArgumentError, 'invalid task type')
  end

  it 'responds to type' do
    expect(subject).to respond_to :type
  end

  it 'responds to minimum_time' do
    expect(subject).to respond_to :minimum_time
  end

  it 'responds to nominal_distance' do
    expect(subject).to respond_to :nominal_distance
  end

  it 'responds to minimum_distance' do
    expect(subject).to respond_to :minimum_distance
  end

  it 'responds to maximum_distance' do
    expect(subject).to respond_to :maximum_distance
  end

  describe 'AST tasks' do
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

    let(:turnpoints) { [turnpoint_1, turnpoint_2, turnpoint_3, turnpoint_4] }

    describe 'calculated attributes' do
      it 'has a calculated nominal distance' do
        expect(subject.nominal_distance).to be_within(1_000).of(351_000) # within 1km
      end

      it 'has a calculated minimum distance equal to the nominal distance' do
        expect(subject.minimum_distance).to eq(subject.nominal_distance)
      end

      it 'has a calculated maximum distance equal to the nominal distance' do
        expect(subject.maximum_distance).to eq(subject.nominal_distance)
      end
    end
  end
  describe 'AAT tasks' do
    let(:start) do
      Augen::Turnpoint.new(
        type: :start,
        category: :start_line,
        length: 10_000,
        waypoint: Augen::Waypoint.new(
          name: 'Partida - 2',
          country: 'AR',
          latitude: '3305.200S',
          longitude: '06037.400W',
          elevation: '23.8m'
        )
      )
    end

    let(:area_1) do
      Augen::Turnpoint.new(
        type: :turnpoint,
        category: :area_cylinder,
        length: 15_000,
        waypoint: Augen::Waypoint.new(
          name: 'Cnel Bogado',
          country: 'AR',
          latitude: '3319.017S',
          longitude: '06036.117W',
          elevation: '0.0m'
        )
      )
    end

    let(:area_2) do
      Augen::Turnpoint.new(
        type: :turnpoint,
        category: :area_cylinder,
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

    let(:finish) do
      Augen::Turnpoint.new(
        type: :finish,
        category: :finish_cylinder,
        length: 3_000,
        waypoint: Augen::Waypoint.new(
          name: 'Llegada 19',
          country: 'AR',
          latitude: '3302.483S',
          longitude: '06035.783W',
          elevation: '23.8m'
        )
      )
    end

    subject do
      described_class.new(
        type: 'AAT',
        minimum_time: 120, # minutes
        turnpoints: [start, area_1, area_2, finish]
      )
    end

    it 'requires a minimum_time' do
      expect do
        described_class.new(
          type: 'AAT',
          minimum_time: nil,
          turnpoints: [start, area_1, area_2, finish]
        )
      end.to raise_error(ArgumentError, 'minimum_time is needed for AAT tasks')
    end

    describe 'calculated attributes' do
      it 'has a calculated nominal distance' do
        expect(subject.nominal_distance).to be_within(1_000).of(173_000) # within 1km
      end

      it 'has a calculated minimum distance' do
        pending 'Not implemented yet'
        expect(subject.minimum_distance).to be_within(1_000).of(117_000) # within 1km
      end

      it 'has a calculated maximum distance' do
        pending 'Not implemented yet'
        expect(subject.maximum_distance).to be_within(1_000).of(236_000) # within 1km
      end
    end
  end
end
