module GeoWorks
  class VectorWorkShowPresenter < GeoWorksShowPresenter
    self.file_format_service = VectorFormatService
  end
end
