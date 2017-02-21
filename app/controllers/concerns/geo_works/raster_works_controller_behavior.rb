module GeoWorks
  module RasterWorksControllerBehavior
    extend ActiveSupport::Concern

    included do
      self.show_presenter = GeoWorks::RasterWorkShowPresenter
    end
  end
end
