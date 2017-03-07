module GeoWorks
  class EventsGenerator
    class_attribute :services

    # Array of event generator services.
    # - GeoblacklightEventGenerator: syncronizes with geoblacklight instance.
    # - GeoserverEventGenerator: syncronizes with geoserver instance.
    self.services = [
      GeoblacklightEventGenerator,
      GeoserverEventGenerator
    ]

    delegate :record_created, to: :generators
    delegate :record_deleted, to: :generators
    delegate :record_updated, to: :generators
    delegate :derivatives_created, to: :generators

    def generators
      @generators ||= CompositeGenerator.new(
        services.map(&:new)
      )
    end
  end
end
