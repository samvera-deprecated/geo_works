module GeoConcerns
  module RasterWorksControllerBehavior
    extend ActiveSupport::Concern

    included do
      self.show_presenter = GeoConcerns::RasterWorkShowPresenter
    end
  end
end
