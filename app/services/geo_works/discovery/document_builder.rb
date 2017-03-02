module GeoWorks
  module Discovery
    class DocumentBuilder
      class_attribute :services, :root_path_class

      # Array of document builder services.
      # - BasicMetadataBuilder: builds fields such as id, subject, and publisher.
      # - SpatialBuilder: builds spatial fields such as bounding box and solr geometry.
      # - DateBuilder: builds date fields such as layer year and modified date.
      # - ReferencesBuilder: builds service reference fields such as thumbnail and download url.
      # - LayerInfoBuilder: builds fields about the geospatial file such as geometry and format.
      # - SlugBuilder: builds the Geoblacklight slug field.
      self.services = [
        BasicMetadataBuilder,
        SpatialBuilder,
        DateBuilder,
        ReferencesBuilder,
        LayerInfoBuilder,
        SlugBuilder
      ]

      # Class used to generate urls for links in the document.
      self.root_path_class = DocumentPath

      def initialize(geo_concern, document)
        @geo_concern = geo_concern
        @document = document
        builders.build(document)
      end

      attr_reader :geo_concern, :document
      delegate :to_json, :to_xml, :to_hash, to: :document

      private

        # Instantiates a CompositeBuilder object with an array of
        # builder instances that are used to create the document.
        # @return [CompositeBuilder] composite builder for document
        def builders
          @builders ||= CompositeBuilder.new(
            services.map { |service| service.new(geo_concern) }
          )
        end
    end
  end
end
