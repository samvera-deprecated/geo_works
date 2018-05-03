class VectorWork < ActiveFedora::Base
  include ::GeoWorks::BasicGeoMetadata
  include ::GeoWorks::GeoreferencedBehavior
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::VectorWorkBehavior
  include ::Hyrax::BasicMetadata

  self.valid_child_concerns = []
  self.human_readable_type = 'Vector Work'
  self.indexer = VectorWorkIndexer

  validates :title, presence: { message: 'Your work must have a title.' }
end
