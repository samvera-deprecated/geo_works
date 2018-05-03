module GeoWorks
  module FileSetsControllerBehavior
    extend ActiveSupport::Concern
    included do
      self.show_presenter = ::FileSetPresenter
      self.form_class = Hyrax::Forms::FileSetEditForm
    end

    # Render geo file sets form if parent is a geo work
    def new
      if geo?
        render 'geo_works/file_sets/new'
      else
        super
      end
    end

    # inject mime_type into permitted params
    def file_set_params
      super.tap do |permitted_params|
        permitted_params[:geo_mime_type] = params[:file_set][:geo_mime_type]
      end
    end

    # 999
    # Override this method from hyrax to use
    # file_set_params instead of params[:file_set],
    # else I get a strong params errors in spec/features/vector_work_show_spec.rb.
    # Is this a bug in hyrax?  Or just a problem with interaction between geo_works and hyrax?
    # Also see this:
    # https://github.com/samvera/hyrax/issues/400
    # 999
    def process_non_empty_file(file:)
      # Relative path is set by the jquery uploader when uploading a directory
      curation_concern.relative_path = params[:relative_path] if params[:relative_path]
      actor.create_metadata(file_set_params)
      actor.attach_to_work(find_parent_by_id)
      if actor.create_content(file)
        response_for_successfully_processed_file
      else
        msg = curation_concern.errors.full_messages.join(', ')
        flash[:error] = msg
        json_error "Error creating file #{file.original_filename}: #{msg}"
      end
    end

    protected

      def geo?
        parent.image_work? || parent.raster_work? || parent.vector_work?
      end
  end
end
