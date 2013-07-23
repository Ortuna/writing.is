require 'test_helper'

class GithubAuthIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, fake_hash)
  end

  test 'login with github' do
    get_via_redirect '/auth/github'
    assert_equal repos_path, path
  end

end
