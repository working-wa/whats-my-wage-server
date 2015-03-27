var DefinitionsView = function (definitionService) {
  this.initialize = function () {
      // Define a div wrapper for the view (used to attach events)
      this.$el = $('<div/>');
      this.render();
  };

  this.render = function() {
    var definitions = definitionService.getDefinitions();
    for(var i in definitions){
      definitions[i].id = i.replace(/\s/g,"-");
      definitions[i].text = i;
    }
    this.$el.html(this.template(definitions));
    return this;
  };

  this.initialize();
}

