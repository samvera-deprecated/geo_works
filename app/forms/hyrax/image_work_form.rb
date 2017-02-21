module Hyrax
  class ImageWorkForm < Hyrax::Forms::WorkForm
    include ::GeoWorks::BasicGeoMetadataForm
    include ::GeoWorks::ExternalMetadataFileForm
    self.model_class = ::ImageWork
  end
end
