module Hyrax
  class VectorWorkForm < Hyrax::Forms::WorkForm
    include ::GeoWorks::BasicGeoMetadataForm
    include ::GeoWorks::GeoreferencedForm
    include ::GeoWorks::ExternalMetadataFileForm
    self.model_class = ::VectorWork
  end
end
