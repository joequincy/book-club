class BooksController < ApplicationController

  def index
    @books = if params[:sort]
      case params[:sort]
      when 'reviews' then Book.by_reviews(params[:direction])
      when 'pages' then Book.by_pages(params[:direction])
      end
    else
      Book.all
    end
    @reviews = Review.all
  end

  def show
    @book = Book.find(params[:id])
  end
end
