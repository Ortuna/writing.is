require 'spec_helper'

describe 'Github authorization' do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github, fake_hash)
  end

  it 'can login with github' do
    get '/auth/github/callback'
    expect(response).to redirect_to(editor_path)
  end

end
