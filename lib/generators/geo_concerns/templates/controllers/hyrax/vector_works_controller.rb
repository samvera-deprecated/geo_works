class Hyrax::VectorWorksController < ApplicationController
  include Hyrax::WorksControllerBehavior
  include Hyrax::ParentContainer
  include GeoConcerns::VectorWorksControllerBehavior
  include GeoConcerns::GeoblacklightControllerBehavior
  include GeoConcerns::MessengerBehavior
  self.curation_concern_type = VectorWork
end
