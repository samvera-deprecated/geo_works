class Hyrax::ImageWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include GeoConcerns::ImageWorksControllerBehavior
  include GeoConcerns::GeoblacklightControllerBehavior
  include GeoConcerns::MessengerBehavior
  self.curation_concern_type = ImageWork
end
