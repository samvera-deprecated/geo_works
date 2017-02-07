require 'uri'

##
# Delivers derivatives to external services, like GeoServer
##
class DeliveryJob < ActiveJob::Base
  queue_as Hyrax.config.ingest_queue_name

  attr_reader :file_set

  ##
  # Precondition is that all derivatives are created and saved.
  # @param [FileSet] file_set
  # @param [String] content_url contains the display copy to deliver
  def perform(message)
    @file_set = ActiveFedora::Base.find(message['id'])
    uri = URI.parse(content_url)
    return if uri.path == ''
    GeoConcerns::DeliveryService.new(file_set, uri.path).publish
  end

  def content_url
    case file_set.geo_mime_type
    when *GeoConcerns::RasterFormatService.select_options.map(&:last)
      return derivatives_service.send(:derivative_url, 'display_raster')
    when *GeoConcerns::VectorFormatService.select_options.map(&:last)
      return derivatives_service.send(:derivative_url, 'display_vector')
    else
      return ''
    end
  end

  def derivatives_service
    GeoConcerns::FileSetDerivativesService.new(file_set)
  end
end
