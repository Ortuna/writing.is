Editor = Ember.Application.create({
  needs: ['user']
});

Editor.Router.map(function(){
  this.route("repos", {path: '/repos'});
});
