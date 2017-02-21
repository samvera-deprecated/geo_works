module GeoWorks
  module PopulateMetadataHelper
    def external_metadata_file_presenters
      GeoWorksShowPresenter.new(curation_concern, nil).external_metadata_file_set_presenters
    end
  end
end
