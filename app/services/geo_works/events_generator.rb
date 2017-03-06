module GeoWorks
  class EventsGenerator
    delegate :record_created, to: :generators
    delegate :record_deleted, to: :generators
    delegate :record_updated, to: :generators
    delegate :derivatives_created, to: :generators

    def generators
      @generators ||= CompositeGenerator.new(
        geoblacklight_event_generator,
        geoserver_event_generator
      )
    end

    private

      def geoblacklight_event_generator
        GeoblacklightEventGenerator.new
      end

      def geoserver_event_generator
        GeoserverEventGenerator.new
      end
  end
end
