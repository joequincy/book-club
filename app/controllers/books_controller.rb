class BooksController < ApplicationController

  def index
    @books = Book.all
    @reviews = Review.all
  end

  def show
    @book = Book.find(params[:id])
  end

end
