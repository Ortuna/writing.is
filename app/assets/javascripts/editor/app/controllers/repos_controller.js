Editor.ReposController = Ember.Controller.extend({
  init: function(){
    this._super();
    this.set('gh', Editor.github);
  }
})
