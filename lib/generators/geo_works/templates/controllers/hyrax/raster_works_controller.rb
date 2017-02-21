class Hyrax::RasterWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include Hyrax::ParentContainer
  include GeoWorks::RasterWorksControllerBehavior
  include GeoWorks::GeoblacklightControllerBehavior
  include GeoWorks::MessengerBehavior
  self.curation_concern_type = RasterWork
end
