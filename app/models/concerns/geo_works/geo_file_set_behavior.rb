module GeoWorks
  module GeoFileSetBehavior
    extend ActiveSupport::Concern
    include ::GeoWorks::GeoFileFormatBehavior
    include ::GeoWorks::ImageFileBehavior
    include ::GeoWorks::RasterFileBehavior
    include ::GeoWorks::VectorFileBehavior
    include ::GeoWorks::ExternalMetadataFileBehavior
    include ::GeoWorks::FileSetMetadata
  end
end
