require 'augen/waypoint'

RSpec.describe Augen::Waypoint do
  %w(name code country latitute longitude elevation).each do |attr|
    it "has a #{attr} reader" do
      expect(subject).to respond_to(attr)
    end
  end
end
