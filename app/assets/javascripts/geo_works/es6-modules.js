//= require geo_works/geo_works_boot
//= require geo_works/relationships

Blacklight.onLoad(function() {
  Initializer = require('geo_works/geo_works_boot')
  window.gc = new Initializer()
})
