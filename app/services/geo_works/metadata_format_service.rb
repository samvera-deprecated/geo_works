module GeoWorks
  class MetadataFormatService
    include GeoWorks::AuthorityService
    self.authority = Qa::Authorities::Local.subauthority_for('metadata_formats')
  end
end
