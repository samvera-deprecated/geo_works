class RasterWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::RasterWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoWorks::BasicGeoMetadata
  include ::GeoWorks::GeoreferencedBehavior
  self.valid_child_concerns = [VectorWork]
end
