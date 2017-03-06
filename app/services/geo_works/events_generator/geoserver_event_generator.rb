module GeoWorks
  class EventsGenerator
    class GeoserverEventGenerator
      def derivatives_created(record)
        return unless geo_file?(record)
        publish_message(
          message("CREATED", record)
        )
      end

      # Message that file set has update.
      def record_updated(record)
        return unless geo_file?(record)
        publish_message(
          message("UPDATED", record)
        )
      end

      def message(type, record)
        base_message(type, record)
      end

      private

        def geo_file?(record)
          record.respond_to?(:geo_file_format?) && record.geo_file_format?
        end

        def base_message(type, record)
          {
            "id" => record.id,
            "event" => type
          }
        end

        def publish_message(message)
          DeliveryJob.perform_later(message)
        end
    end
  end
end
