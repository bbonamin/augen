# frozen_string_literal: true
require 'augen/waypoint'
require 'augen/turnpoint'
require 'augen/task'

RSpec.describe Augen::Task do
  let(:turnpoints) { [] }

  subject do
    described_class.new(
      type: 'AST',
      minimum_time: 120, # minutes
      turnpoints: turnpoints
    )
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
  describe 'AAT tasks'
end
