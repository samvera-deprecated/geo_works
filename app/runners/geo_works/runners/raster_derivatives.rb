module GeoWorks
  module Runners
    class RasterDerivatives < Hydra::Derivatives::Runner
      def self.processor_class
        GeoWorks::Processors::Raster::Processor
      end
    end
  end
end
