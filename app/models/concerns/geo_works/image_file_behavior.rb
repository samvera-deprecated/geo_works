module GeoWorks
  # Attributes and methods for image files
  module ImageFileBehavior
    extend ActiveSupport::Concern

    # Retrieve the Image Work of which this Object is a member
    # @return [GeoWorks::ImageWork]
    def image_work
      parents.select do |parent|
        parent.class.included_modules.include?(::GeoWorks::ImageWorkBehavior)
      end.to_a
    end
  end
end
