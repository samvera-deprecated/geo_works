module GeoWorks
  class RasterWorkShowPresenter < GeoWorksShowPresenter
    self.file_format_service = GeoWorks::RasterFormatService
  end
end
