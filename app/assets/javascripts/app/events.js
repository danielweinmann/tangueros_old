App.Events = {
  Index: Backbone.View.extend({
    initialize: function(){
    }
  }),
  Show: Backbone.View.extend({
    initialize: function(){
      if($('#map').data("latitude") && $('#map').data("longitude")) {
        handler = Gmaps.build('Google', {zoom: 8});
        handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
          marker = {
            "lat": $('#map').data("latitude"),
            "lng": $('#map').data("longitude")
          }
          markers = handler.addMarkers([marker]);
          handler.bounds.extendWith(markers);
          handler.fitMapToBounds();
          handler.getMap().setZoom(16);
        })
      }
    }
  })
};
