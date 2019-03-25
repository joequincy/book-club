require 'rails_helper'

RSpec.describe 'User', type: :model do

  describe 'queries' do
    it 'should sort by review date' do
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

      date_sorted_desc = Review.user_by_date(user: 'Lydia Mora', dir: 'DESC')
      expect(date_sorted_desc.first.description).to eq(@review_07.description)
      expect(date_sorted_desc.last.description).to eq(@review_03.description)

      date_sorted_asc = Review.user_by_date(user: 'Lydia Mora', dir: 'ASC')
      expect(date_sorted_asc.first.description).to eq(@review_03.description)
      expect(date_sorted_asc.last.description).to eq(@review_07.description)
    end
  end
end
