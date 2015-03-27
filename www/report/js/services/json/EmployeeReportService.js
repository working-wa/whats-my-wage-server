var EmployerSizeService = function() {

    this.initialize = function(url) {
        var deferred = $.Deferred();

        this.url = "http://localhost:3000/v1/employer/employer_size" ? url

        deferred.resolve();
        return deferred.promise();
    }

    this.submitReport = function(report) {
      var deferred = $.Deferred();

      console.log("Report: " + JSON.stringify(report));

      $.post({
        url: this.url + "/report",
        data: report,
        dataType: "json",
        success: function(data) {
          console.log("Request succeeded");
          deferred.resolve();
        },
        error: function(reply, status, errorThrown) {
          console.log("Request failed");
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
