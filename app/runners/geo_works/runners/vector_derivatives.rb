module GeoWorks
  module Runners
    class VectorDerivatives < Hydra::Derivatives::Runner
      def self.processor_class
        GeoWorks::Processors::Vector::Processor
      end
    end
  end
end
