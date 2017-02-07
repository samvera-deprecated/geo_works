module GeoConcerns
  module ImageWorksControllerBehavior
    extend ActiveSupport::Concern

    included do
      self.show_presenter = GeoConcerns::ImageWorkShowPresenter
    end
  end
end
