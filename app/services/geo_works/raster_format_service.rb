module GeoWorks
  class RasterFormatService
    include GeoWorks::AuthorityService
    self.authority = Qa::Authorities::Local.subauthority_for('raster_formats')
  end
end
