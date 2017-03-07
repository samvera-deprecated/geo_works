module GeoWorks
  module EventsBehavior
    extend ActiveSupport::Concern

    def destroy
      geo_works_events_generator.record_deleted(geo_work)
      super
    end

    def after_create_response
      super
      geo_works_events_generator.record_created(geo_work)
    end

    def after_update_response
      super
      geo_works_events_generator.record_updated(geo_work)
    end

    def geo_works_events_generator
      @geo_works_events_generator ||= GeoWorks::EventsGenerator.new
    end

    def geo_work
      doc = SolrDocument.new(curation_concern.to_solr)
      show_presenter.new(doc, current_ability, request)
    end
  end
end
