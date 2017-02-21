module GeoWorks
  class ImageFormatService
    include GeoWorks::AuthorityService
    self.authority = Qa::Authorities::Local.subauthority_for('image_formats')
  end
end
