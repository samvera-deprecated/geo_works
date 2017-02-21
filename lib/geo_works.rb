require 'hyrax'
require "geo_works/engine"
require 'leaflet-rails'

module GeoWorks
  def self.root
    Pathname.new(File.expand_path('../../', __FILE__))
  end
end
