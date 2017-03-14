require 'spec_helper'

describe GeoWorks::Discovery::GeoblacklightDocument do
  subject { described_class.new }

  describe '#to_hash' do
    before do
      allow(subject).to receive(:rights).and_return('Public')
      allow(subject).to receive(:document_hash).and_return(document_hash)
    end
    context 'incomplete data' do
      let(:document_hash) { Hash.new }

      it 'fails to validate the document hash' do
        expect(subject.to_hash).to include(:error)
        expect(subject.to_hash[:error].size).to eq(6)
      end
    end
  end
end
