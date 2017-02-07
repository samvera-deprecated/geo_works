class Hyrax::RasterWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include Hyrax::ParentContainer
  include GeoConcerns::RasterWorksControllerBehavior
  include GeoConcerns::GeoblacklightControllerBehavior
  include GeoConcerns::MessengerBehavior
  self.curation_concern_type = RasterWork
end
