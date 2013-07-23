require 'spec_helper'

describe OmniauthGithubController do

  before(:each) do 
    User.delete_all
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, fake_hash)
  end

  it 'callback routes' do
    assert_routing("/user/login/callback", 
                   :controller => "omniauth_github", :action => "callback")
  end

  it 'user is created with callback from github' do
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 
    get :callback

    User.first.uid.should == 'uid'
    User.first.provider.should == 'github'
  end

  it 'redirect on valid auth' do
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 

    get :callback
    assert_redirected_to repos_path
  end

  it 'redirect on invalid auth' do
    get :callback
    assert_redirected_to user_login_path
  end

  it 'auth an already existing user' do
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    get :callback

    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    get :callback
    assert_redirected_to repos_path
  end

  # test 'redirect to error when invalid session'
  
end
