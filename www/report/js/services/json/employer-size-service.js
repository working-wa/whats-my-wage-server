var EmployerSizeService = function() {

    this.initialize = function(url) {
        var deferred = $.Deferred();

        if(typeof url == "undefined") {
          this.url = "http://minimum-wage-service.herokuapp.com/api/v1/employer_size";
        } else {
          this.url = url;
        }

        deferred.resolve();
        return deferred.promise();
    }

    this.submitReport = function(report) {
      var deferred = $.Deferred();

      $.ajax(this.url + "/report", {
        method: "POST",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(report),
        dataType: "json",
        processData: false,
        success: function(data) {
          deferred.resolve();
        },
        error: function(reply, status, errorThrown) {
          deferred.reject(reply, status, errorThrown)
        }
      });

      return deferred.promise();
    }

    this.findByName = function(name) {
        var deferred = $.Deferred();

        $.getJSON(this.url + "/report", params, function(data) {
          deferred.resolve(data.size);

        });
        return deferred.promise();
    }
}
