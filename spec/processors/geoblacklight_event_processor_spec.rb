require 'spec_helper'

RSpec.describe GeoWorks::GeoblacklightEventProcessor do
  subject(:processor) { described_class.new(event) }
  let(:client) { instance_double(RSolr::Client) }
  let(:id) { 'stanford-dp018hs9766' }
  let(:title) { 'geo title' }
  let(:event) do
    {
      'id' => id,
      'event' => type,
      'doc' => geoblacklight_document
    }
  end
  let(:geoblacklight_document) do
    {
      'layer_slug_s' => id,
      'dc_title_s' => title
    }
  end

  before do
    allow(RSolr).to receive(:connect).and_return(client)
  end

  context 'when given an unknown event' do
    let(:type) { 'UNKNOWNEVENT' }
    it 'returns false' do
      expect(processor.process).to eq false
    end
  end

  context 'when given a creation event with an invalid document' do
    let(:type) { 'CREATED' }
    it 'returns false' do
      error = RSolr::Error::Http.new 'test', 'test'
      expect(client).to receive(:update).and_raise(error)
      expect(processor.process).to eq false
    end
  end

  context 'when given a creation event with an valid document' do
    let(:type) { 'CREATED' }
    it 'adds the geoblacklight document' do
      doc = '[{"layer_slug_s":"stanford-dp018hs9766","dc_title_s":"geo title"}]'
      expect(client).to receive(:update).with(hash_including(data: doc))
      expect(client).to receive(:commit)
      expect(processor.process).to eq true
    end
  end

  context 'when given an update event' do
    let(:type) { 'UPDATED' }
    let(:title) { 'updated geo title' }
    it 'updates that resource' do
      doc = '[{"layer_slug_s":"stanford-dp018hs9766","dc_title_s":"updated geo title"}]'
      expect(client).to receive(:update).with(hash_including(data: doc))
      expect(client).to receive(:commit)
      expect(processor.process).to eq true
    end
  end

  context 'when given a delete event' do
    let(:type) { 'DELETED' }
    it 'deletes that resource' do
      expect(client).to receive(:delete_by_query)
      expect(client).to receive(:commit)
      expect(processor.process).to eq true
    end
  end
end
