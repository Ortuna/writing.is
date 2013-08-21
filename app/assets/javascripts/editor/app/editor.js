var Editor = angular.module('Editor', []);
var github  = new Github({ token: auth_token, auth: "oauth"});

Editor.factory('githubFactory', function($q, $rootScope){
  var factory = {}
  factory.getUser  = function() {
    return github.getUser();
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
  
  factory.getRepo  = function(username, reponame){
    return github.getRepo(username, reponame);
  };

  factory.getRepos = function() {
    var deferred = $q.defer();
    this.getUser().repos(function(error, repos){
      $rootScope.$apply(function() { deferred.resolve(repos);});
    });
    return deferred.promise;
  };

  factory.getContents = function(repo, path) {
    var deferred = $q.defer();
    repo.contents('master', path, function(err, data) {
      angular.forEach(data, function(value, key) {
        data[key].encodedPath = Base64.encode(data[key].path);
      });
      $rootScope.$apply(function() { deferred.resolve(data); });
    });
    return deferred.promise;
  };

  factory.getFile = function(repo, file) {
    var deferred = $q.defer();
    repo.read('master', file, function(err, data) {
      $rootScope.$apply(function() { deferred.resolve(data); });
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
    $scope.path    = $routeParams["dir"] ? "/" + Base64.decode($routeParams["dir"]) : "";
    $scope.repo    = githubFactory.getRepo($routeParams["user"], $routeParams["repo"]);
    $scope.tree    = githubFactory.getContents($scope.repo, $scope.path);
  },
  EditorController: function($scope, githubFactory, $routeParams) {
    $scope.$emit('hideHeader');
    $scope.params  = $routeParams;
    $scope.repo    = githubFactory.getRepo($routeParams["user"], $routeParams["repo"]);
    $scope.path    = $routeParams["file"] ? Base64.decode($routeParams["file"]) : "";
    $scope.file    = githubFactory.getFile($scope.repo, $scope.path);
    $scope.editorOptions = {
        lineWrapping : true,
        lineNumbers: true,
        readOnly: 'nocursor',
        mode: 'xml',
    };
  },
  ApplicationController: function($scope) {
    $scope.showHeader = true;
    $scope.$on('showHeader', function(){
      $scope.showHeader = true;
    });

    $scope.$on('hideHeader', function(){
      $scope.showHeader = false;
    });
  },
});

Editor.config(function($routeProvider){
  $routeProvider.when('/repos', {
    controller: 'ReposController',
    templateUrl: 'assets/editor/partials/repos.html'
  })
  .when('/repo/:user/:repo',  {
    controller: 'RepoController',
    templateUrl: 'assets/editor/partials/repo.html'
  })
  .when('/repo/:user/:repo/:dir',  {
    controller: 'RepoController',
    templateUrl: 'assets/editor/partials/repo.html'
  })
  .when('/edit/:user/:repo/:file', {
    controller: 'EditorController',
    templateUrl: 'assets/editor/partials/editor.html'
  })
  .otherwise({redirectTo: '/repos'});
});


