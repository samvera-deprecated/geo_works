require 'spec_helper'

RSpec.describe GeoWorks::EventsGenerator::GeoserverEventGenerator do
  subject { described_class.new }
  let(:id) { 'geo-work-1' }
  let(:file_set) { instance_double(FileSet, id: id, geo_file_format?: true) }

  before do
    allow(DeliveryJob).to receive(:perform_later)
  end

  describe "#derivatives_created" do
    it "publishes a persistent JSON message" do
      expected_result = {
        "id" => id,
        "event" => "CREATED"
      }
      subject.derivatives_created(file_set)
      expect(DeliveryJob).to have_received(:perform_later).with(expected_result)
    end
  end
end
