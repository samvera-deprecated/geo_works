module Hyrax
  class FileSetsController < ApplicationController
    include Hyrax::FileSetsControllerBehavior
    include GeoConcerns::FileSetsControllerBehavior
    include GeoConcerns::MessengerBehavior
  end
end
