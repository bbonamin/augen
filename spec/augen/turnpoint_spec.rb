# frozen_string_literal: true
require 'augen/waypoint'
require 'augen/turnpoint'

RSpec.describe Augen::Turnpoint do
  let(:waypoint) do
    Augen::Waypoint.new(
      name: 'Rosario Apt',
      code: 'SAAR',
      country: 'AR',
      latitude: '3254.150S',
      longitude: '06047.117W',
      elevation: '0.0m'
    )
  end
  subject do
    described_class.new(
      type: :start,
      category: :start_line,
      length: 10_000,
      waypoint: waypoint
    )
  end

  %w(type category length waypoint).each do |attr|
    it "has a #{attr} reader" do
      expect(subject).to respond_to(attr)
    end
  end

  describe '#type' do
    it 'only accepts valid values as type' do
      %i(start finish turnpoint).each do |type|
        expect do
          described_class.new(
            type: type,
            category: :start_line,
            length: 10_000,
            waypoint: waypoint
          )
        end.to_not raise_error
      end
    end

    it 'does not accept random values as type' do
      %i(foo bar a1 trap).each do |type|
        expect do
          described_class.new(
            type: type,
            category: :start_line,
            length: 10_000,
            waypoint: waypoint
          )
        end.to raise_error(ArgumentError, 'invalid type')
      end
    end
  end
  describe '#category' do
    it 'only accepts valid values as category' do
      %i(
        start_line
        turn_point_cylinder
        finish_cylinder
      ).each do |category|
        expect do
          described_class.new(
            type: :start,
            category: category,
            length: 500,
            waypoint: waypoint
          )
        end.to_not raise_error
      end
    end

    it 'does not accept random values as category' do
      %i(foo bar a1 trap).each do |category|
        expect do
          described_class.new(
            type: :start,
            category: category,
            length: 10_000,
            waypoint: waypoint
          )
        end.to raise_error(ArgumentError, 'invalid category')
      end
    end
  end
  describe '#bearing_to' do
    let(:target_1) do
      described_class.new(
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

    let(:target_2) do
      described_class.new(
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

    subject do
      described_class.new(
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

    it 'returns about 355 degrees bearing to `target_1`' do
      expect(subject.bearing_to(target_1)).to be_within(0.00001).of(355.55141)
    end

    it 'returns about 256 degrees bearing to `target_2`' do
      expect(subject.bearing_to(target_2)).to be_within(0.00001).of(256.53374)
    end
  end
  describe '#bearing_average' do
    it 'returns the clockwise average for angles that are completely opposite' do
      expect(subject.bearing_average(0, 180)).to eq(90)
      expect(subject.bearing_average(180, 0)).to eq(270)
    end

    it 'returns the closest average for any other pairs of angles' do
      expect(subject.bearing_average(180, 1)).to eq(90.5)
      expect(subject.bearing_average(1, 180)).to eq(90.5)
      expect(subject.bearing_average(20, 350)).to eq(5)
      expect(subject.bearing_average(350, 20)).to eq(5)
      expect(subject.bearing_average(10, 20)).to eq(15)
      expect(subject.bearing_average(350, 2)).to eq(356)
      expect(subject.bearing_average(359, 0)).to eq(359.5)
      expect(subject.bearing_average(180, 180)).to eq(180)
    end
  end
end
