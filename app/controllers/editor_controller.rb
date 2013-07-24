class EditorController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @current_user = current_user
    # @user_id      = params[:user_id]
    # @repos        = get_user_repos(current_user)
  end

end
