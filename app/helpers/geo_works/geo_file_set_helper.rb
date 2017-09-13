module GeoWorks
  module GeoFileSetHelper
    def file_set_geometry(presenter)
      presenter.solr_document.fetch(Solrizer.solr_name('geometry_type'), ['']).first
    end
  end
end
