# frozen_string_literal: true
require 'augen/waypoint'

RSpec.describe Augen::Waypoint do
  subject do
    described_class.new(latitude: '3254.150S', longitude: '06047.117W')
  end

  %w(name code country latitude longitude elevation).each do |attr|
    it "has a #{attr} reader" do
      expect(subject).to respond_to(attr)
    end
  end

  it 'can be initialized and preserves arguments' do
    waypoint = described_class.new(
      name: 'Rosario Apt',
      code: 'SAAR',
      country: 'AR',
      latitude: '3254.150S',
      longitude: '06047.117W',
      elevation: '0.0m'
    )

    expect(waypoint.name).to eq('Rosario Apt')
    expect(waypoint.code).to eq('SAAR')
    expect(waypoint.country).to eq('AR')
    expect(waypoint.latitude).to eq('3254.150S')
    expect(waypoint.longitude).to eq('06047.117W')
    expect(waypoint.elevation).to eq('0.0m')
  end

  describe '#latitude_dd' do
    it 'returns its latitude in decimal degrees' do
      expect(subject.latitude_dd).to eq(-32.9025)
    end
  end

  describe '#latitude_rad' do
    it 'returns its latitude in radians' do
      expect(subject.latitude_rad).to be_within(0.0000000001).of(-0.5742569571)
    end
  end

  describe '#longitude_dd' do
    it 'returns its longitude in decimal degrees' do
      expect(subject.longitude_dd).to eq(-60.785283)
    end
  end

  describe '#longitude_rad' do
    it 'returns its longitude in radians' do
      expect(subject.longitude_rad).to be_within(0.0000000001).of(-1.0609033251)
    end
  end
end
