class ImageWork < ActiveFedora::Base
  include ::GeoWorks::BasicGeoMetadata
  include ::Hyrax::WorkBehavior
  include ::GeoWorks::ImageWorkBehavior
  include ::Hyrax::BasicMetadata

  self.valid_child_concerns = [RasterWork]
  self.human_readable_type = 'Image Work'
  self.indexer = ImageWorkIndexer

  validates :title, presence: { message: 'Your work must have a title.' }
end
