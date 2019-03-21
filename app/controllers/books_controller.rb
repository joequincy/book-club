class BooksController < ApplicationController

  def index
    @sorted_books = if params[:sort]
      direction = params[:direction]
      case params[:sort]
      when 'reviews'
        Book.by_reviews(dir: direction)
      when 'pages'
        Book.by_pages(dir: direction)
      when 'rating'
        Book.by_average_ratings(dir: direction, limit: false)
      else
        Book.all
      end
    else
      Book.all
    end
    @books = Book.all
    @reviews = Review.all
  end

  def show
    @book = Book.find(params[:id])
  end
end
