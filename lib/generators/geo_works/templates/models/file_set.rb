class FileSet < ActiveFedora::Base
  include ::Hyrax::FileSetBehavior
  include ::GeoWorks::GeoFileSetBehavior
end
