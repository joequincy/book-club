class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    # authors = book_params[:authors].split(',').map do |author|
    author = Author.create(name: book_params[:authors])
    author.books.create(title: book_params[:title],
                    pages: book_params[:pages],
                    year_published: book_params[:year_published],
                    thumbnail: book_params[:thumbnail])

    redirect_to book_path(author.books.first)
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year_published, :thumbnail)
  end

end
