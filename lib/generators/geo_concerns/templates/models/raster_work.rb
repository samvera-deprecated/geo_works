class RasterWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoConcerns::RasterWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoConcerns::BasicGeoMetadata
  include ::GeoConcerns::GeoreferencedBehavior
  self.valid_child_concerns = [VectorWork]
end
