class BooksController < BaseController
  protect_from_forgery with: :exception

  def show
    render text: 'done'
  end

  def index
    @current_user = current_user
    # client = Octokit::Client.new(:login => "me", :oauth_token => @current_user[:auth_token])
  end
end
