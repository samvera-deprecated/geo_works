module GeoWorks
  # Attributes and methods for basic geospatial metadata used by Works
  module FileSetMetadata
    extend ActiveSupport::Concern

    included do
      apply_schema ::GeoWorks::FileSetMetadataRequired,
                   ActiveFedora::SchemaIndexingStrategy.new(
                     ActiveFedora::Indexers::GlobalIndexer.new(
                       [:stored_searchable, :symbol]
                     )
                   )
    end
  end
end
