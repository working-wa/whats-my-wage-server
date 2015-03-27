var NoteView = function(note) {
  this.initialize = function() {
      this.$el = $('<div/>');
      this.render();
  };

  this.render = function() {
      this.$el.html(this.template(note));
      return this;
  };

  this.initialize();
}

