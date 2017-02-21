class VectorWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::VectorWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoWorks::BasicGeoMetadata
  include ::GeoWorks::GeoreferencedBehavior
  self.valid_child_concerns = []
end
