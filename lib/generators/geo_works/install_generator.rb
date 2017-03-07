require 'rails/generators'

module GeoWorks
  class Install < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    attr_accessor :class_name

    def install_routes
      inject_into_file 'config/routes.rb', after: /curation_concerns_embargo_management\s*\n/ do
        "  mount GeoWorks::Engine => '/'\n"\
      end
    end

    def install_ability
      inject_into_file 'app/models/ability.rb', after: "include Hyrax::Ability\n" do
        "  include GeoWorks::Ability\n"
      end
    end

    def register_work
      inject_into_file 'config/initializers/hyrax.rb', after: "Hyrax.config do |config|\n" do
        "  # Injected via `rails g geo_works:install`\n" \
          "  config.register_curation_concern :vector_work\n" \
          "  config.register_curation_concern :raster_work\n" \
          "  config.register_curation_concern :image_work\n"
      end
    end

    def install_raster_work
      @class_name = 'RasterWork'
      install_work
      install_specs
    end

    def install_vector_work
      @class_name = 'VectorWork'
      install_work
      install_specs
    end

    def install_image_work
      @class_name = 'ImageWork'
      install_work
      install_specs
    end

    def install_file_sets_controller
      file_path = 'app/controllers/hyrax/file_sets_controller.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /include Hyrax::FileSetsControllerBehavior.*$/ do
          "\n    include GeoConcerns::FileSetsControllerBehavior\n" \
            "    include GeoConcerns::EventsBehavior\n"
        end
      else
        copy_file 'controllers/hyrax/file_sets_controller.rb', file_path
      end
    end

    def copy_hyrax_derivate_path_monkey_patch
      file_path = 'config/initializers/hyrax_derivative_path_monkey_patch.rb'
      copy_file file_path, file_path
    end

    def install_authorities
      %w(metadata image vector raster).each do |type|
        file_path = "config/authorities/#{type}_formats.yml"
        copy_file file_path, file_path
      end
    end

    def inject_into_file_set
      file_path = 'app/models/file_set.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /include ::Hyrax::FileSetBehavior.*$/ do
          "\n  # GeoWorks behavior to FileSet.\n" \
            "  include ::GeoWorks::GeoFileSetBehavior\n"
        end
      else
        copy_file 'models/file_set.rb', file_path
      end
    end

    def file_set_presenter
      file_path = 'app/presenters/file_set_presenter.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /class FileSetPresenter.*$/ do
          "\n  # GeoWorks FileSetPresenter behavior\n" \
            "  include ::GeoWorks::FileSetPresenterBehavior\n"
        end
      else
        copy_file 'presenters/file_set_presenter.rb', file_path
      end
    end

    # Add behaviors to the SolrDocument model
    def inject_solr_document_behavior
      file_path = 'app/models/solr_document.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /include Blacklight::Solr::Document.*$/ do
          "\n  # Adds GeoWorks behaviors to the SolrDocument.\n" \
            "  include GeoWorks::SolrDocumentBehavior\n"
        end
      else
        Rails.logger.info "     \e[31mFailure\e[0m  GeoWorks requires a SolrDocument object. This generators assumes that the model is defined in the file #{file_path}, which does not exist."
      end
    end

    def install_js_assets
      file_path = 'app/assets/javascripts/application.js'
      inject_into_file file_path, before: %r{\/\/= require_tree \..*$} do
        "//= require geo_works/application\n" \
        "//= require hyrax\n" \
        "// Require es6 modules after almond is loaded in hyrax.\n" \
        "//= require geo_works/es6-modules\n"
      end
    end

    def install_css_assets
      file_path = 'app/assets/stylesheets/application.css'
      inject_into_file file_path, before: /\*= require_tree \..*$/ do
        "*= require geo_works/application\n "
      end
    end

    def inject_derivative_service_into_hyrax_initializer
      file_path = 'config/initializers/hyrax.rb'
      append_to_file file_path do
        "# Add derivative service for GeoWorks\n" \
          "Hyrax::DerivativeService.services = [GeoWorks::FileSetDerivativesService] + Hyrax::DerivativeService.services\n"
      end
    end

    private

      def install_work
        name = @class_name.underscore
        model_path = "app/models/#{name}.rb"
        actor_path = "app/actors/hyrax/actors/#{name}_actor.rb"
        controller_path = "app/controllers/hyrax/#{name.pluralize}_controller.rb"
        copy_file "models/#{name}.rb", model_path
        copy_file "actors/hyrax/actors/#{name}_actor.rb", actor_path
        copy_file "controllers/hyrax/#{name.pluralize}_controller.rb", controller_path
      end

      def install_specs
        name = @class_name.underscore
        template 'spec/model_spec.rb.erb', "spec/models/#{name}_spec.rb"
        template 'spec/actor_spec.rb.erb', "spec/actors/#{name}_actor_spec.rb"
        template 'spec/controller_spec.rb.erb', "spec/controllers/#{name.pluralize}_controller_spec_spec.rb"
      end
  end
end
