require 'spec_helper'
require 'uri'

describe GeoWorks::GeoblacklightJob do
  let(:message) { { 'id' => 'ab', 'event' => 'CREATED' } }

  describe '#perform' do
    let(:processor) { instance_double('GeoWorks::GeoblacklightEventProcessor') }

    context 'local image file' do
      it 'delegates to DeliveryService' do
        expect(GeoWorks::GeoblacklightEventProcessor).to receive(:new).with(message).and_return(processor)
        expect(processor).to receive(:process)
        subject.perform(message)
      end
    end
  end
end
