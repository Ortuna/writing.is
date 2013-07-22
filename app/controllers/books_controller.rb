class BooksController < BaseController
  protect_from_forgery with: :exception

  def show
    render text: 'done'
  end

  def index
    @current_user = current_user
    flash[:warn] = 'Ohh noze!'
  end
end
