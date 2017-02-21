module GeoWorks
  # Attributes and methods for vector files
  module VectorFileBehavior
    extend ActiveSupport::Concern
    include ::GeoWorks::GeoreferencedBehavior
    # Retrieve the Vector Work of which this Object is a member
    # @return [GeoWorks::VectorWork]
    def vector_work
      parents.select do |parent|
        parent.class.included_modules.include?(::GeoWorks::VectorWorkBehavior)
      end.to_a
    end
  end
end
