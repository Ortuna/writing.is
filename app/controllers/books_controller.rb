class BooksController < BaseController
  protect_from_forgery with: :exception
  def show
    render text: 'done'
  end

  def index
    render text: 'done'
  end
end