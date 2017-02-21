module GeoWorks
  class ImageWorkShowPresenter < GeoWorksShowPresenter
    self.file_format_service = ImageFormatService
  end
end
