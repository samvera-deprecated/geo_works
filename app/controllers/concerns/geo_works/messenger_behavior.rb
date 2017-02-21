module GeoWorks
  module MessengerBehavior
    extend ActiveSupport::Concern

    def destroy
      geo_works_messenger.record_deleted(geo_concern)
      super
    end

    def after_create_response
      super
      geo_works_messenger.record_created(geo_concern)
    end

    def after_update_response
      super
      geo_works_messenger.record_updated(geo_concern)
    end

    def geo_works_messenger
      @geo_works_messenger ||= GeoWorks::Messaging.messenger
    end

    def geo_concern
      doc = SolrDocument.new(curation_concern.to_solr)
      show_presenter.new(doc, current_ability, request)
    end
  end
end
