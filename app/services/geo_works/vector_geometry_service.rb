module GeoWorks
  class VectorGeometryService
    attr_reader :file_set, :file_path

    def initialize(file_set, file_path)
      @file_set = file_set
      @file_path = file_path.gsub('file:', '')
    end

    # Extracts geometry type from display vector and saves value in FileSet.
    def call
      file_set.geometry_type = geometry
      file_set.save!
    end

    private

      def geometry
        unzip_display_vector
        GeoWorks::Processors::Vector::Info.new(shapefile_dir).geom
      end

      def shapefile_dir
        "#{File.dirname(file_path)}/#{File.basename(file_path, '.zip')}"
      end

      def unzip_display_vector
        system "unzip -o #{file_path} -d #{shapefile_dir}" unless File.directory?(shapefile_dir)
      end
  end
end
