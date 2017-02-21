class ImageWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::ImageWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoWorks::BasicGeoMetadata
  self.valid_child_concerns = [RasterWork]
end
