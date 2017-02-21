module GeoWorks
  class VectorFormatService
    include GeoWorks::AuthorityService
    self.authority = Qa::Authorities::Local.subauthority_for('vector_formats')
  end
end
