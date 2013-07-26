var Editor = angular.module('Editor', []);
var github  = new Github({ token: auth_token, auth: "oauth"});

Editor.factory('githubFactory', function($q, $rootScope){
  var factory = {}
  factory.getUser  = function() {
    return github.getUser();
  };

  factory.getRepo  = function(username, reponame){
    return github.getRepo(username, reponame);
  };

  factory.getProfile = function() {
    var deferred = $q.defer();
    this.getUser().show(null, function(error, user){
      $rootScope.$apply(function() {
        var profile  = {}
        profile.id    = user.id;
        profile.name  = user.login;
        profile.image = user.avatar_url;
        deferred.resolve(profile);        
      });
    });
    return deferred.promise;
  };

  factory.getRepos = function() {
    var deferred = $q.defer();
    this.getUser().repos(function(error, repos){
      $rootScope.$apply(function() {
        deferred.resolve(repos);
      });
    });
    return deferred.promise;
  };

  factory.getTree = function(username, reponame) {
    var deferred = $q.defer();
    this.getRepo(username, reponame).getTree('master?recursive=1', function(error, tree) {
      $rootScope.$apply(function() {
        console.debug(tree);
        deferred.resolve(tree);
      });
    });
    return deferred.promise;
  };

  return factory;
});

Editor.controller({
  ProfileController: function($scope, githubFactory) {
    $scope.profile = githubFactory.getProfile();
  },
  ReposController: function($scope, githubFactory) {
    $scope.repos   = githubFactory.getRepos(); 
  },
  RepoController: function($scope, githubFactory, $routeParams) {
    $scope.params  = $routeParams;
    $scope.tree    = githubFactory.getTree($routeParams["user"], $routeParams["repo"]);
  }
});

Editor.config(function($routeProvider){
  $routeProvider.when('/repos',
  {
    controller: 'ReposController',
    templateUrl: 'assets/editor/partials/repos.html'
  })
  .when('/repo/:user/:repo', 
  {
    controller: 'RepoController',
    templateUrl: 'assets/editor/partials/repo.html'
  })
  .otherwise({redirectTo: '/repos'});
});


