module GeoConcerns
  class FileSetDerivativesService < Hyrax::FileSetDerivativesService
    attr_reader :file_set
    delegate :id, :geo_mime_type, to: :file_set

    def initialize(file_set)
      @file_set = file_set
    end

    def valid?
      supported_geo_mime_types.include?(geo_mime_type)
    end

    def create_derivatives(filename)
      case geo_mime_type
      when *GeoConcerns::RasterFormatService.select_options.map(&:last)
        create_raster_derivatives(filename)
      when *GeoConcerns::VectorFormatService.select_options.map(&:last)
        create_vector_derivatives(filename)
      end

      # Once all the derivatives are created, send a derivatives created message
      geo_concerns_messenger.derivatives_created(file_set)
    end

    private

      def create_raster_derivatives(filename)
        GeoConcerns::Runners::RasterDerivatives
          .create(filename, outputs: [{ input_format: geo_mime_type,
                                        label: :display_raster,
                                        id: id,
                                        format: 'tif',
                                        url: derivative_url('display_raster') },
                                      { input_format: geo_mime_type,
                                        label: :thumbnail,
                                        id: id,
                                        format: 'png',
                                        size: '200x150',
                                        url: derivative_url('thumbnail') }])
      end

      def create_vector_derivatives(filename)
        GeoConcerns::Runners::VectorDerivatives
          .create(filename, outputs: [{ input_format: geo_mime_type,
                                        label: :display_vector,
                                        id: id,
                                        format: 'zip',
                                        url: derivative_url('display_vector') },
                                      { input_format: geo_mime_type,
                                        label: :thumbnail,
                                        id: id,
                                        format: 'png',
                                        size: '200x150',
                                        url: derivative_url('thumbnail') }])
      end

      def supported_geo_mime_types
        GeoConcerns::RasterFormatService.select_options.map(&:last) +
          GeoConcerns::VectorFormatService.select_options.map(&:last)
      end

      def geo_concerns_messenger
        @geo_concerns_messenger ||= GeoConcerns::Messaging.messenger
      end
  end
end
