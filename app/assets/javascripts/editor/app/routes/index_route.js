Editor.IndexRoute = Ember.Route.extend({
  redirect: function() {
    this.transitionTo('repos');
  }
});
