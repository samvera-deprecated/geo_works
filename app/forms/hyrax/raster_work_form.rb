module Hyrax
  class RasterWorkForm < Hyrax::Forms::WorkForm
    include ::GeoWorks::BasicGeoMetadataForm
    include ::GeoWorks::GeoreferencedForm
    include ::GeoWorks::ExternalMetadataFileForm
    self.model_class = ::RasterWork
  end
end
