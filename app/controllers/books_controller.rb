class BooksController < ApplicationController

  def index
    @books = Book.all
    @reviews = Review.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    author_names = params[:authors].split(',')
    book = Book.new(book_params)
    if Book.already_exists?(book)
      redirect_to new_book_path
    else
    book.save
    assign_book_to_author(author_names, book)
    redirect_to book_path(book.id)
    end
  end

  def assign_book_to_author(author_names, book)
    author_names.each do |name|
      author = Author.find_or_create_by(name: name.strip)
      author.books << book
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :pages, :year_published, :thumbnail)
  end

end
