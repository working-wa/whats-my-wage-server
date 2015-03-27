var WageService = function() {
    this.initialize = function() {
        // No Initialization required
        var deferred = $.Deferred();
        deferred.resolve();
        return deferred.promise();
    }

    this.findByAnswers = function(answers) {
      var deferred = $.Deferred();

      console.log("Answers: " + JSON.stringify(answers));

      var schedule;

      if(answers["work-seattle"] == "yes") {
        if(answers["number-employees"] == ">500") {
          if(answers["medical-benefits"] == "no") {
            schedule = "A";
          } else {
            schedule = "B";
          }
        } else {
          if(answers["min-compensation"] == "yes") {
            schedule = "C";
          } else {
            schedule = "D";
          }
        }
      } else {
        schedule = "Washington State";
      }

      console.log("Schedule: " + schedule);

      var intervals = [];
      var current;

      for (wageInterval in wageSchedules[schedule]){
          current = wageSchedules[schedule][wageInterval];
          console.log(JSON.stringify(current));

          if(!current.time_range.isPast()){
            console.log("Interval is now or in the future");
            intervals.push(current);
          } else {
            console.log("Interval is in the past");
          }
      }

      deferred.resolve(intervals);
      return deferred.promise();
    }

    // A = Schedule 1 employers (more than 500 employees in the U.S.)
    // B = Schedule 1 employers (more than 500 emp1loyees in the U.S.) with medical benefits
    // C = Schedule 2 employers (500 or fewer employees in the U.S.) with minimum compensation
    // D = Schedule 2 employers (500 or fewer employees in the U.S.)
    var wageSchedules = {
      "A": [
        {"wage": 9.54, "time_range": moment("2014-01-01").twix("2015-03-31", {allDay: true})},
        {"wage": 11.0, "time_range": moment("2015-04-01").twix("2015-12-31", {allDay: true})},
        {"wage": 13.0, "time_range": moment("2016-01-01").twix("2016-12-31", {allDay: true})},
        {"wage": 15.0, "time_range": moment("2017-01-01").twix("2117-12-31", {allDay: true})}
      ],
      "B": [
        {"wage": 9.54, "time_range": moment("2014-01-01").twix("2015-03-31", {allDay: true})},
        {"wage": 11.0, "time_range": moment("2015-04-01").twix("2015-12-31", {allDay: true})},
        {"wage": 12.5, "time_range": moment("2016-01-01").twix("2016-12-31", {allDay: true})},
        {"wage": 13.5, "time_range": moment("2017-01-01").twix("2017-12-31", {allDay: true})},
        {"wage": 15.0, "time_range": moment("2018-01-01").twix("2118-12-31", {allDay: true})}
      ],
      "C": [
        {"wage": 9.54, "time_range": moment("2014-01-01").twix("2015-03-31", {allDay: true})},
        {"wage": 11.0, "time_range": moment("2015-04-01").twix("2015-12-31", {allDay: true})},
        {"wage": 12.0, "time_range": moment("2016-01-01").twix("2016-12-31", {allDay: true})},
        {"wage": 13.0, "time_range": moment("2017-01-01").twix("2017-12-31", {allDay: true})},
        {"wage": 14.0, "time_range": moment("2018-01-01").twix("2018-12-31", {allDay: true})},
        {"wage": 15.0, "time_range": moment("2019-01-01").twix("2119-12-31", {allDay: true})}
      ],
      "D": [
        {"wage": 9.54, "time_range": moment("2014-01-01").twix("2015-03-31", {allDay: true})},
        {"wage": 10.0, "time_range": moment("2015-04-01").twix("2015-12-31", {allDay: true})},
        {"wage": 10.5, "time_range": moment("2016-01-01").twix("2016-12-31", {allDay: true})},
        {"wage": 11.0, "time_range": moment("2017-01-01").twix("2017-12-31", {allDay: true})},
        {"wage": 11.5, "time_range": moment("2018-01-01").twix("2018-12-31", {allDay: true})},
        {"wage": 12.0, "time_range": moment("2019-01-01").twix("2019-12-31", {allDay: true})},
        {"wage": 13.5, "time_range": moment("2020-01-01").twix("2020-12-31", {allDay: true})},
        {"wage": 15.0, "time_range": moment("2021-01-01").twix("2121-12-31", {allDay: true})}
      ],
      "Washington State": [
        {"wage":9.47,"time_range": moment("2015-01-01").twix("2115-12-31", {allDay: true})} 
      ]
    };
}
