require 'test_helper'
class OmniauthGithubControllerTest < ActionController::TestCase
  def setup
    OmniAuth.config.test_mode = true
  end

  test 'callback routes' do
    assert_routing("/user/login/callback", 
                   :controller => "omniauth_github", :action => "callback")
  end

  test 'user is created with callback from github' do
    OmniAuth.config.add_mock(:github, fake_hash)
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 

    get :callback
    assert_equal 'uid',   User.first.uid
    assert_equal 'github', User.first.provider
  end

  test 'redirect on valid auth' do
    OmniAuth.config.add_mock(:github, fake_hash)
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 

    get :callback
    assert_redirected_to books_path
  end

  test 'redirect on invalid auth' do
    get :callback
    assert_redirected_to user_login_path
  end

  test 'auth an already existing user' do
    OmniAuth.config.add_mock(:github, fake_hash)
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

    get :callback

    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    get :callback
    assert_redirected_to books_path
  end

  # test 'redirect to error when invalid session'
  
end
