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
end
