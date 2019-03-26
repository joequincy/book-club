class BooksController < ApplicationController

  def index
    @books = if params[:sort]
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
    @worst_3 = Book.worst_3
    @best_3 = Book.best_3
    @top_reviewers = Review.top_reviewers
  end

  def show
    @book = Book.find(params[:id])
    @top_reviews = @book.top_reviews(3)
    @bottom_reviews = @book.bottom_reviews(3)
  end

  def new
    @book = Book.new
    @authors = ""
    if session[:book]
      @book = Book.new(session[:book])
      @authors = session[:authors]
      session[:book] = nil
      session[:authors] = nil
      @book.valid?
      if !authors_valid?(@authors)
        @book.errors.add(:base, :book_needs_at_least_one_author,
        message: "Author(s) must not be empty")
      end
    end
  end

  def create
    author_names = params[:authors].split(',')
    @book = Book.new(book_params)
    if authors_valid?(params[:authors]) && @book.save
      assign_book_to_author(author_names, @book)
      redirect_to book_path(@book.id)
    else
      session[:book] = params[:book]
      session[:authors] = params[:authors]
      redirect_to new_book_path
    end
  end


  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def assign_book_to_author(author_names, book)
    author_names.each do |name|
      author = Author.find_or_create_by(name: name.strip)
      author.books << book
    end
  end

  def book_params
    bp = params.require(:book).permit(:title, :authors, :pages, :year_published, :thumbnail)
    bp[:title] = bp[:title].titleize
    if bp[:thumbnail] == ""
      bp[:thumbnail] = "https://ibf.org/site_assets/img/placeholder-book-cover-default.png"
    end
    bp
  end

  def authors_valid?(author_string)
    authors = author_string.split(',')
    (authors.length > 0 && authors[0].strip.length > 0)
  end
end
