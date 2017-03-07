require 'spec_helper'

RSpec.describe GeoWorks::EventsGenerator do
  subject { described_class.new }
  let(:file_set) { instance_double(FileSet) }
  let(:generator) { instance_double(GeoWorks::EventsGenerator::GeoserverEventGenerator) }

  before do
    allow(GeoWorks::EventsGenerator::GeoserverEventGenerator).to receive(:new).and_return(generator)
  end

  describe "#derivatives_created" do
    it 'delegates to the geoserver event generator' do
      expect(generator).to receive(:derivatives_created).with(file_set)
      subject.derivatives_created(file_set)
    end
  end
end
