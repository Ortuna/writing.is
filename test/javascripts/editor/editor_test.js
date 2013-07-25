//= require editor/editor

Editor.rootElement = 'body';
Editor.setupForTesting();
Editor.injectTestHelpers();

auth_token = nil;
module("Application Tests", {
  setup: function() { Editor.reset(); }
});

// test("github.js is loaded", function(){
//   ok(Editor.github);
//   ok(Editor.github.client);
//   ok(Editor.github.user);
//   ok(Editor.github.profile);
// });

// test("Redirects to repos as default", function(){
//   visit('/repos').then(function(){
//     console.debug(window.location);
//     equal(window.location, '/repos');
//   });
// });
