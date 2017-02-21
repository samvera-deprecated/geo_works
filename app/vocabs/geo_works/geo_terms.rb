require 'rdf'
module GeoWorks
  class GeoTerms < RDF::Vocabulary('http://projecthydra.org/GeoWorks/models#')
    term :ImageWork
    term :RasterWork
    term :VectorWork
    term :ImageFile
    term :RasterFile
    term :VectorFile
    term :ExternalMetadataFile
  end
end
