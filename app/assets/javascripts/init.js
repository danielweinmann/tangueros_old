jQuery(function () {
  var body, controllerClass, controllerName, action;

  body = $(document.body);
  controllerClass = body.data( "controller-class" );
  controllerName = body.data( "controller-name" );
  action = body.data( "action" );

  function exec(controllerClass, controllerName, action) {
    var ns, railsNS;

    ns = App;
    railsNS = controllerClass ? controllerClass.split("::").slice(0, -1) : [];

    _.each(railsNS, function(name){
      if(ns) {
        ns = ns[name];
      }
    });

    if ( ns && controllerName && controllerName !== "" ) {
      var capitalizedAction = action.charAt(0).toUpperCase() + action.substr(1);
      if(_.isFunction(ns[controllerName][action])) {
        ns[controllerName][action]();
      }
      else if(_.isFunction(ns[controllerName][capitalizedAction])) {
        var view = window.view = new ns[controllerName][capitalizedAction]();
      }
    }
  }


  exec( null, "Common", "init" );
  exec( controllerClass, controllerName, "init" );
  exec( controllerClass, controllerName, action );
  exec( null, "Common", "finish" );

});

