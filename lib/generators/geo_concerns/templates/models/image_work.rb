class ImageWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoConcerns::ImageWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoConcerns::BasicGeoMetadata
  self.valid_child_concerns = [RasterWork]
end
