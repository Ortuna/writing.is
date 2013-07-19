require 'test_helper'

class GithubAuthIntegrationTest < ActionDispatch::IntegrationTest

  def fake_hash
    fake_github_hash = {
      provider: 'github',
      uid:      '1234',
      info: {
        name: 'test_user',
        image: 'some_string',
        role:  'author'
      }
    }.with_indifferent_access
  end

  def setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, fake_hash)
  end

  test 'login with github' do
    get_via_redirect '/auth/github'
    assert_equal books_path, path
  end

end
