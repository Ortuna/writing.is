require 'test_helper'
class OmniauthGithubControllerTest < ActionController::TestCase
  def setup
    OmniAuth.config.test_mode = true
  end

  test 'callback route' do
    assert_routing("/user/login/callback", 
                   :controller => "omniauth_github", :action => "callback")
  end

  test 'user is created with callback from github' do
    fake_github_hash = {
      provider: 'github',
      uid:      '1234',
      info: {
        name: 'test_user',
        image: 'some_string',
        role:  'author'
      }
    }.with_indifferent_access

    OmniAuth.config.add_mock(:github, fake_github_hash)
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 

    get :callback
    assert User.first.uid      == '1234'
    assert User.first.provider == 'github'
  end
end
