module GeoWorks
  module GeoFileSetBehavior
    extend ActiveSupport::Concern
    include ::GeoWorks::GeoFileFormatBehavior
    include ::GeoWorks::ImageFileBehavior
    include ::GeoWorks::ExternalMetadataFileBehavior
  end
end
