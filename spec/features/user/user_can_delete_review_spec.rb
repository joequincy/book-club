require 'rails_helper'

RSpec.describe 'user: delete reviews', type: :feature do

  before(:each) do
    @author_1 = Author.create(name: "Larry Niven")
    @book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    AuthorBook.create(author_id: @author_1.id, book_id: @book_1.id)
    @review_03 = @book_1.reviews.create(user: "Lydia Mora", rating: 5, title: "Outstanding book!",
      description: "The plot makes sense...", created_at: 17.days.ago)
    @review_06 = @book_1.reviews.create(user: "Lydia Mora", rating: 5, title: "Not Niven's best stuff",
      description: "This is a quick read...", created_at: 5.days.ago)
    @review_07 = @book_1.reviews.create(user: "Lydia Mora", rating: 3, title: "A fun sci-fi take on Dante's Inferno",
      description: "Very entertaining SF/F revision...", created_at: 2.days.ago)
    @review_20 = @book_1.reviews.create(user: "Lydia Mora", rating: 4, title: "Lovely",
      description: "The Return of the King...", created_at: 4.days.ago)
  end

  it 'should allow user to delete review' do
    visit user_path('Lydia Mora')

    click_on("delete-review-#{@review_03.id}")

    expect(page).to_not have_content("The plot makes sense")
  end

  it 'should redirect to main page if user has no more reviews' do
    visit user_path('Lydia Mora')

    click_on("delete-review-#{@review_03.id}")
    click_on("delete-review-#{@review_06.id}")
    click_on("delete-review-#{@review_07.id}")
    click_on("delete-review-#{@review_20.id}")

    expect(page).to have_current_path(books_path)
  end
end
