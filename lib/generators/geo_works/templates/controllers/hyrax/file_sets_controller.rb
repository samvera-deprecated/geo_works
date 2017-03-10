module Hyrax
  class FileSetsController < ApplicationController
    include Hyrax::FileSetsControllerBehavior
    include GeoWorks::FileSetsControllerBehavior
    include GeoWorks::EventsBehavior
  end
end
