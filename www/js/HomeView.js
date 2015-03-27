var HomeView = function (answerService) {
  this.initialize = function () {
      // Define a div wrapper for the view (used to attach events)
      this.$el = $('<div/>');
      this.$el.on('click', '.start-survey', this.startSurvey);
      this.render();
  };

  this.startSurvey = function(event) {
    answerService.clear();
  };

  this.render = function() {
    this.$el.html(this.template());
    return this;
  };

  this.initialize();
}
