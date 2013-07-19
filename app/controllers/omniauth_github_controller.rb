class OmniauthGithubController < BaseController
  protect_from_forgery with: :exception

  def callback
    auth    = request.env["omniauth.auth"]
    account = User.create_with_omniauth(auth)

    if account
      redirect_to books_path
    else
      flash[:error] = 'A login error has occured'
      redirect_to user_login_path
    end

  end
end
