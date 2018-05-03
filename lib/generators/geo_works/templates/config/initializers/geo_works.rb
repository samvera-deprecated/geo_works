# Rails.application.config.after_initialize do
Hyrax::Engine.config.after_initialize do
  Hyrax::FileSetsController.prepend GeoWorks::FileSetsControllerBehavior
  Hyrax::FileSetsController.prepend GeoWorks::EventsBehavior
end
