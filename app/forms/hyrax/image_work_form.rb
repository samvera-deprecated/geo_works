module Hyrax
  class ImageWorkForm < Hyrax::Forms::WorkForm
    include ::GeoConcerns::BasicGeoMetadataForm
    include ::GeoConcerns::ExternalMetadataFileForm
    self.model_class = ::ImageWork
  end
end
