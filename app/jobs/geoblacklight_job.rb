require 'uri'
require 'geoblacklight_messaging'

# Loads geoblacklight
class GeoblacklightJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    # Stub out processing
    # GeoblacklightMessaging::GeoblacklightEventProcessor.new(message).process
  end
end
