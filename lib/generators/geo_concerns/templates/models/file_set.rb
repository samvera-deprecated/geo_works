class FileSet < ActiveFedora::Base
  include ::Hyrax::FileSetBehavior
  include ::GeoConcerns::GeoFileSetBehavior
end
