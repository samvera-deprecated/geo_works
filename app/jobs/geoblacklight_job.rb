require 'uri'

# Loads geoblacklight
class GeoblacklightJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    GeoWorks::GeoblacklightEventProcessor.new(message).process
  end
end
