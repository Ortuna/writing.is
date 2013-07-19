class OmniauthGithubController < BaseController
  protect_from_forgery with: :exception

  def callback
    auth    = request.env["omniauth.auth"]
    account = User.create_with_omniauth(auth)

    if account
      redirect_to books_path
    else
      redirect_to user_login_path
    end
    # account ? redirect_and_set_current_account(account) : redirect_auth_failed
  end
end
