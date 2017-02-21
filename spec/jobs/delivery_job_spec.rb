require 'spec_helper'
require 'uri'

describe GeoWorks::DeliveryJob do
  let(:id) { 'ab' }
  let(:message) { { 'id' => id, 'event' => 'CREATED', "exchange" => :geoserver } }
  let(:content_url) { 'file:/somewhere-to-display-copy' }
  let(:file_format) { 'application/zip; ogr-format="ESRI Shapefile"' }
  let(:file_set) { instance_double(FileSet, id: id, geo_mime_type: file_format) }

  before do
    allow(ActiveFedora::Base).to receive(:find).and_return(file_set)
    allow(Hyrax.config).to receive(:derivatives_path).and_return(content_url)
  end

  describe '#perform' do
    let(:service) { instance_double('GeoWorks::DeliveryService') }
    context 'local vector file' do
      it 'delegates to DeliveryService' do
        file_path = "#{content_url}/#{id}-display_vector.zip"
        expect(GeoWorks::DeliveryService).to receive(:new).with(file_set, URI(file_path).path).and_return(service)
        expect(service).to receive(:publish)
        subject.perform(message)
      end
    end

    context 'local raster file' do
      let(:file_format) { 'image/tiff; gdal-format=GTiff' }
      it 'delegates to DeliveryService' do
        file_path = "#{content_url}/#{id}-display_raster.tif"
        expect(GeoWorks::DeliveryService).to receive(:new).with(file_set, URI(file_path).path).and_return(service)
        expect(service).to receive(:publish)
        subject.perform(message)
      end
    end

    context 'local image file' do
      let(:file_format) { 'image/jpeg' }
      it 'delegates to DeliveryService' do
        expect(GeoWorks::DeliveryService).not_to receive(:new)
        subject.perform(message)
      end
    end
  end
end
