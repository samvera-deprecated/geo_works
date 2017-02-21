module GeoWorks
  module ImageWorksControllerBehavior
    extend ActiveSupport::Concern

    included do
      self.show_presenter = GeoWorks::ImageWorkShowPresenter
    end
  end
end
