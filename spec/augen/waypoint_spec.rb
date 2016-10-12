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
end
