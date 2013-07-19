class OmniauthGithubController < ActionController::Base
  protect_from_forgery with: :exception

  def callback
    auth    = request.env["omniauth.auth"]
    account = User.create_with_omniauth(auth)
    redirect_to '/'
    # account ? redirect_and_set_current_account(account) : redirect_auth_failed
  end
end
