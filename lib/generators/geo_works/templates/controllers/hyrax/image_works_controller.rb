class Hyrax::ImageWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include GeoWorks::ImageWorksControllerBehavior
  include GeoWorks::GeoblacklightControllerBehavior
  include GeoWorks::EventsBehavior
  self.curation_concern_type = ImageWork
end
