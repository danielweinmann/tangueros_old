var App = window.App = {
  Common: {
    init: function(){
      // Start JS router if it's not started yet
      if(!App.routes && _.isFunction(App.Router)){
        App.routes = new App.Router();
      }

      // Create existing flashes
      App.flashes = [];
      $('.flash').each(function(){
        App.flashes.push(new PLOTO.Flash({el: this}));
      });
    },

    finish: function(){
      if(Backbone.history) {
        Backbone.history.start();
      }
    },
  }
};

