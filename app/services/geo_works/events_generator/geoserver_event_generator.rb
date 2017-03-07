module GeoWorks
  class EventsGenerator
    class GeoserverEventGenerator
      def derivatives_created(record)
        return unless geo_file_set?(record)
        publish_message(
          message("CREATED", record)
        )
      end

      private

        def publish_message(message)
          GeoserverDeliveryJob.perform_later(message)
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

        def geo_file_set?(record)
          record.respond_to?(:geo_file_format?) && record.geo_file_format?
        end
    end
  end
end
