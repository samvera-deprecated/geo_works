class VectorWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior
  include ::GeoConcerns::VectorWorkBehavior
  include ::Hyrax::BasicMetadata
  include ::GeoConcerns::BasicGeoMetadata
  include ::GeoConcerns::GeoreferencedBehavior
  self.valid_child_concerns = []
end
