// We use an "Immediate Function" to initialize the application to avoid leaving anything behind in the global scope
(function () {

    var employerSizeService = new EmployerSizeService();

    $.when([employerSizeService.initialize()]).done(function() {
      console.log("Services initialized");
      $(".submit").on("click", function(evt) {
        evt.preventDefault();

        if (!$(".certify-correct .toggle").hasClass("active")) {
          return alert("You must certify that the information you have entered is correct to the best of your knowledge!");
        }

        var name = $("#employer-size-report #employer-name").val();
        var streetAddress = $("#employer-size-report #employer-street-address").val();

        var nameDefined = (typeof name != "undefined" && name != "");
        var addressDefined = (typeof streetAddress != "undefined" && streetAddress != "");

        $(".errors ul").html("");

        if(!nameDefined || !addressDefined) {
          $(".errors").removeClass("hidden");

          $(".error .error-header").html("Report Not Submitted! Missing required values:");

          if(!nameDefined) {
            $(".errors ul").append("<li>Name Of Business</li>");
          }

          if(!addressDefined) {
            $(".errors ul").append("<li>Street Address</li>");
          }

          window.scrollTo(0,0);

          return
        } else {
          $(".errors").addClass("hidden");
        }

        var deferred = employerSizeService.submitReport($("#employer-size-report").serializeObject());
        deferred.done(function(){ window.location = "/"; });
      });
    });

    /* --------------------------------- Event Registration -------------------------------- */

    $(".certify-correct .toggle").on("click", function() {
      var toggle = $(this);
      if(toggle.hasClass("active")){
        toggle.removeClass("active");
      } else {
        toggle.addClass("active");
      }
    });


    if ('addEventListener' in document) {
      document.addEventListener('deviceready', function () {
        StatusBar.overlaysWebView( false );
        StatusBar.backgroundColorByHexString('#ffffff');
        StatusBar.styleDefault();

        if (navigator.notification) { // Override default HTML alert with native dialog
            window.alert = function (message) {
                navigator.notification.alert(
                    message,    // message
                    null,       // callback
                    "Forgotten Incidents", // title
                    'OK'        // buttonName
                );
            };
        }
      }, false);
    }

    FastClick.attach(document.body);
}());
