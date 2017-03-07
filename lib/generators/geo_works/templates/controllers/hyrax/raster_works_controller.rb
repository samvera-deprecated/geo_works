class Hyrax::RasterWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include Hyrax::ParentContainer
  include GeoWorks::RasterWorksControllerBehavior
  include GeoWorks::GeoblacklightControllerBehavior
  include GeoWorks::EventsBehavior
  self.curation_concern_type = RasterWork
end
