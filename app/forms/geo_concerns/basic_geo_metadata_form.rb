module GeoConcerns
  module BasicGeoMetadataForm
    extend ActiveSupport::Concern
    included do
      self.terms += [:spatial, :temporal, :coverage, :issued]
      self.required_fields += [:coverage]
    end
  end
end
