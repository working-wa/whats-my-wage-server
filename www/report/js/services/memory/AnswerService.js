var AnswerService = function() {
    this.initialize = function() {
        // No Initialization required
        var deferred = $.Deferred();
        deferred.resolve();
        return deferred.promise();
    }

    this.saveAnswer = function(id, value) {
        this.answers[id] = value;
    }

    this.clear = function() {
      this.answers = {};
    }

    this.getAnswers = function() {
      var deferred = $.Deferred();
      deferred.resolve(this.answers);
      return deferred.promise();
    }

    this.answers = {};
}
