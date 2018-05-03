class RasterWork < ActiveFedora::Base
  include ::GeoWorks::BasicGeoMetadata
  include ::GeoWorks::GeoreferencedBehavior
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::RasterWorkBehavior
  include ::Hyrax::BasicMetadata

  self.valid_child_concerns = [VectorWork]
  self.human_readable_type = 'Raster Work'
  self.indexer = RasterWorkIndexer

  validates :title, presence: { message: 'Your work must have a title.' }
end
