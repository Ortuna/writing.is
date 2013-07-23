class ReposController < ApplicationController
  protect_from_forgery with: :exception

  def show
    render text: 'done'
  end

  def index
    @current_user = current_user
    @repos = get_user_repos(current_user)
  end

  private

  def get_user_repos(current_user)
    token   = current_user[:auth_token]
    @client = Octokit::Client.new(:login => "me", :oauth_token => token)
    @client.repos.tap { |r| flash[:success] = 'Updated repo list from github' }
  end
end
