module GeoWorks
  class GeoblacklightEventProcessor
    class Processor
      attr_reader :event
      def initialize(event)
        @event = event
      end

      private

        def event_type
          event['event']
        end

        def id
          event['id']
        end

        def doc
          event['doc']
        end

        def index
          RSolr.connect(url: GeoWorks::Geoblacklight.config['url'])
        end
    end
  end
end
