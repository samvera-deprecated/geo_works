require 'spec_helper'

RSpec.describe GeoWorks::EventsGenerator::GeoserverEventGenerator do
  subject { described_class.new }
  let(:id) { 'geo-work-1' }
  let(:file_set) { instance_double(FileSet, id: id, geo_file_format?: true) }

  before do
    allow(DeliveryJob).to receive(:perform_later)
  end

  describe "#record_created" do
    it "publishes a persistent JSON message" do
      expected_result = {
        "id" => id,
        "event" => "CREATED"
      }
      subject.record_created(file_set)
      expect(DeliveryJob).to have_received(:perform_later).with(expected_result)
    end
  end

  describe "#record_updated" do
    it "publishes a persistent JSON message with new title" do
      expected_result = {
        "id" => id,
        "event" => "UPDATED"
      }
      subject.record_updated(file_set)
      expect(DeliveryJob).to have_received(:perform_later).with(expected_result)
    end
  end
end
