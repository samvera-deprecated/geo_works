module GeoWorks
  module Extractors
    module FgdcHelper
      def extract_fgdc_metadata(doc)
        GeoWorks::Extractors::FgdcMetadataExtractor.new(doc).to_hash
      end
    end
  end
end
