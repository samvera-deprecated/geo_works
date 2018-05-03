class Hyrax::VectorWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include Hyrax::BreadcrumbsForWorks
  # include Hyrax::ParentContainer # need this ???
  include GeoWorks::VectorWorksControllerBehavior
  include GeoWorks::GeoblacklightControllerBehavior
  include GeoWorks::EventsBehavior

  self.curation_concern_type = ::VectorWork
end
