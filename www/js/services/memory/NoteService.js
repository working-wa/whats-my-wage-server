var NoteService = function() {

    this.initialize = function() {
        // No Initialization required
        var deferred = $.Deferred();
        deferred.resolve();
        return deferred.promise();
    }

    this.findById = function(id) {
        var deferred = $.Deferred();
        var note = null;
        var l = notes.length;
        for (var i=0; i < l; i++) {
            if (notes[i].id == id) {
                note = notes[i];
                break;
            }
        }
        deferred.resolve(note);
        return deferred.promise();
    }

    var notes = [
        {
          "id": "part-time-seattle",
          "title":"Part Time in Seattle",
          "explanation":["If you work more than two hours in Seattle during a two-week period, then Seattle’s minimum wage applies to you. You should be paid Seattle’s minimum wage for those hours.", "You can use this calculator like normal for your Seattle hours; hours worked outside the city should be paid the state minimum wage.", "<b>Note:</b> Hours don’t count if you’re only traveling through Seattle with no work-related stops in the city."],
          "ordinance": {
            "section": "A",
            "href": "https://www.municode.com/library/wa/seattle/codes/municipal_code?nodeId=TIT14HURI_CH14.19MIWAMICORAEMPEWOSE_14.19.020EMSEEMSCDE",
            "text": ["Employees should receive the minimum wage for each hour worked within the geographic boundaries of Seattle, provided that an employee who performs work in Seattle on an occasional basis should receive the appropriate minimum wage in a two-week period only if the employee performs more than two hours of work for an employer within Seattle during that two-week period.","Time spent in Seattle solely for the purpose of travelling through Seattle from a point of origin outside Seattle to a destination outside Seattle, with no employment-related or commercial stops in Seattle except for refueling or the employee's personal meals or errands, are not included."]
          },
          "next":"#question/number-employees",
          "skip": function(answers) {
            return false
          }
        },
        {
          "id": "minimum-compensation",
          "title":"Minimum Compensation",
          "explanation": ["Your employer can pay you a slightly lower base hourly wage as long as the difference is made up by employer contributions to medical insurance, tips, commissions, or other forms of cash bonus."],
          "ordinance": {
            "section":"B",
            "href": "https://www.municode.com/library/wa/seattle/codes/municipal_code?nodeId=TIT14HURI_CH14.19MIWAMICORAEMPEWOSE_14.19.050HOMICOCH2EM",
            "text":["Employers can meet the applicable hourly minimum compensation requirement through wages (including applicable commissions, piece-rate, and bonuses), tips and money paid by an employer towards an individual employee's medical benefits plan, provided that the Schedule 2 employer also meets the applicable hourly minimum wage requirements."]
          },
          "next":"#results",
          "skip": function(answers) {
            return answers["health-insurance"] != "yes" && answers["tips"] != "yes";
          }
        },
    ];

}

