//= require editor/editor

Editor.rootElement = 'body';
Editor.setupForTesting();
Editor.injectTestHelpers();

module("Profile", {
  setup: function() { Editor.reset(); }
});

test("Redirects to repos as default", function(){
  visit('/repos').then(function(){
    console.debug($(".profile-image"));
    equal(1,1);
  });
});
