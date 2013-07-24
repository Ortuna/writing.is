Editor.ProfileController = Ember.Controller.extend({
  github: null,
  setupController: function(controller, user) {
    console.debug('here!')
    controller.set('github', new Github({ token: auth_token, auth: "oauth"}));
  }
})
