class FileSet < ActiveFedora::Base
  # 99999999999999
  # These modules need to be before ::Hyrax::FileSetBehavior, or else I get:
  # ActiveTriples::UndefinedPropertyError:
  # The property `geo_mime_type` is not defined on class 'FileSet::GeneratedResourceSchema'
  #
  # which I think is caused by this:
  # https://github.com/samvera/active_fedora/issues/847
  # 99999999999999
  include ::GeoWorks::FileSetMetadata
  include ::GeoWorks::RasterFileBehavior
  include ::GeoWorks::VectorFileBehavior

  include ::Hyrax::FileSetBehavior
  include ::GeoWorks::GeoFileSetBehavior
end
