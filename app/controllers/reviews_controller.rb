class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    review = Review.new(review_params)
    if Review.already_exists?(review, book)
      redirect_to book_path(book)
    else
      review.save
      book.reviews << review
      redirect_to book_path(book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description, :user)
  end

end
