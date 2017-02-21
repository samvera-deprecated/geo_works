module GeoWorks
  module VectorWorksControllerBehavior
    extend ActiveSupport::Concern

    included do
      self.show_presenter = GeoWorks::VectorWorkShowPresenter
    end
  end
end
