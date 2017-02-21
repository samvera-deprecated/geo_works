module GeoWorks
  module FileSetActionsHelper
    def file_set_actions(presenter, locals = {})
      render file_set_actions_partial(presenter),
             locals.merge(file_set: presenter)
    end

    def file_set_actions_partial(file_set)
      format = file_set_actions_format(file_set)
      'geo_works/file_sets/actions/' +
        if format
          format
        else
          'default_actions'
        end
    end

    def file_set_actions_format(file_set)
      geo_mime_type = file_set.solr_document.fetch(:geo_mime_type_ssim, []).first
      if GeoWorks::ImageFormatService.include?(geo_mime_type)
        'image_actions'
      elsif GeoWorks::VectorFormatService.include?(geo_mime_type)
        'vector_actions'
      elsif GeoWorks::RasterFormatService.include?(geo_mime_type)
        'raster_actions'
      elsif GeoWorks::MetadataFormatService.include?(geo_mime_type)
        'metadata_actions'
      end
    end
  end
end
