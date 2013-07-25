Editor.FilesController = Ember.Controller.extend({
  init: function(){
    this._super();
    this.set('gh', Editor.github);
    console.debug('here in files!');
  }
});
