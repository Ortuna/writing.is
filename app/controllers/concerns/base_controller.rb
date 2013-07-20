class BaseController < ActionController::Base
  layout 'application'

  private
  def current_user
    user_id = session[:user_id]
    user_id ? User.find(user_id) : nil
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
