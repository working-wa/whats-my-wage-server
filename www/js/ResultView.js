var ResultView = function(wageIntervals) {

  this.initialize = function() {
      this.$el = $('<div/>');

      this.$el.on('click', '.btn-see-more', this.revealHidden);

      this.render();

      //  collapsedHeight: 130,
      //  moreLink: "<button class=\"btn btn-primary btn-see-more\">See future wages...</button>"
      //});
  };

  this.render = function() {
      var pretty = [];
      for (interval in wageIntervals) {
          var wage = accounting.formatMoney(wageIntervals[interval].wage);
          var range = wageIntervals[interval].time_range.format({implicitYear: false});

          pretty.push({wage: wage, range: range, raw: wageIntervals[interval]});
      }

      pretty[0].range = "Now - " + pretty[0].raw.time_range.end.format("MMM Do, YYYY")
      pretty[pretty.length - 1].range = "After " + pretty[pretty.length - 1].raw.time_range.start.format("MMM Do, YYYY")

      this.$el.html(this.template(pretty));
      return this;
  };

  this.initialize();
}
