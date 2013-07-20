class BooksController < BaseController
  protect_from_forgery with: :exception

  def show
    render text: 'done'
  end

  def index
    
  end

  private 
  def current_user
    @current_user ||= current_user
  end
end
