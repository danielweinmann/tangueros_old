$(document).ready ->
  if $("body").data("controller") == "events" and $("body").data("action") == "show" and $("body").data("namespace") == null
    if $('#map').data("latitude") and $('#map').data("longitude")
      handler = Gmaps.build('Google', {zoom: 8})
      handler.buildMap { provider: {}, internal: {id: 'map'}}, ->
        marker =
          "lat": $('#map').data("latitude")
          "lng": $('#map').data("longitude")
        markers = handler.addMarkers [marker]
        handler.bounds.extendWith(markers)
        handler.fitMapToBounds()
        handler.getMap().setZoom(16)
