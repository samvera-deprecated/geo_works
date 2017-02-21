module GeoWorks
  # Attributes and methods for raster files
  module RasterFileBehavior
    extend ActiveSupport::Concern
    include ::GeoWorks::GeoreferencedBehavior
    # Retrieve the Raster Work of which this Object is a member
    # @return [GeoWorks::Raster]
    def raster_work
      parents.select do |parent|
        parent.class.included_modules.include?(::GeoWorks::RasterWorkBehavior)
      end.to_a
    end
  end
end
