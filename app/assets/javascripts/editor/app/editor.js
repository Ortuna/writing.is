Editor = Ember.Application.create({
  LOG_TRANSITIONS: true,
});

Ember.LOG_BINDINGS = true

Editor.Router.map(function(){
  this.resource("repos", {path: '/repos'});
  this.resource("files", {path: '/repo/:full_name/files'});
});

github_lib = Ember.Object.extend({
  auth_token: null,
  client:     null,
  user:       null,
  profile:    null,
  repos:      null,
  fetchUser: function() {
    var client = this.get('client');
    this.set('user', client.getUser());
  },
  fetchProfile: function() {
    var object = this;
    this.get('user').show(null, function(err, profile) {
      object.set('profile', profile);
    });
  },
  fetchRepos: function() {
    var object = this;
    this.get('user').repos(function(err, repos) {
      object.set('repos', repos);
    });
  },
  init: function(){
    this._super();
    this.set('client', new Github({ token: this.get('auth_token'), auth: "oauth"}));
    this.fetchUser();
    this.fetchProfile();
    this.fetchRepos();
  }
});

Editor.github = github_lib.create({auth_token: auth_token});
