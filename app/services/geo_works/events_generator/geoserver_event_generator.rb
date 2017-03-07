module GeoWorks
  class EventsGenerator
    class GeoserverEventGenerator
      def record_created(record)
        return unless geo_file?(record)
        publish_message(
          message("CREATED", record)
        )
      end

      def record_deleted(record); end

      def record_updated(record)
        return unless geo_file?(record)
        publish_message(
          message("UPDATED", record)
        )
      end

      private

        def publish_message(message)
          DeliveryJob.perform_later(message)
        end

        def message(type, record)
          base_message(type, record)
        end

        def base_message(type, record)
          {
            "id" => record.id,
            "event" => type
          }
        end

        def geo_file?(record)
          record.respond_to?(:geo_file_format?) && record.geo_file_format?
        end
    end
  end
end
