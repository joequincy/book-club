require 'rails_helper'

RSpec.describe Author, type: :model do

  describe 'relationships' do
    it { should have_many(:author_books) }
    it { should have_many(:books).through(:author_books) }
  end

  describe 'validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a name' do
        author = Author.create
        expect(author).to_not be_valid
      end
    end
  end

  describe 'queries' do
    it 'can get top three authors' do
      @author_1 = Author.create(name: "Larry Niven")
      @book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
      AuthorBook.create(author_id: @author_1.id, book_id: @book_1.id)
      @review_01 = @book_1.reviews.create(user: "Veronica Morgan", rating: 4, title: "A tale of intrigue... but not in the way it sounds",
        description: "The entire time...")
      @review_02 = @book_1.reviews.create(user: "Chris Cobb", rating: 4, title: "Fabulous!",
        description: "Being an engineer by nature...")
      @review_03 = @book_1.reviews.create(user: "Hattie Le", rating: 5, title: "Outstanding book!",
        description: "The plot makes sense...")

      @book_2 = Book.create(title: "The Goliath Stone", pages: 320, year_published: 2013, thumbnail: "https://images-na.ssl-images-amazon.com/images/I/51l%2BUTphB1L.jpg")
      AuthorBook.create(author_id: @author_1.id, book_id: @book_2.id)
      @review_04 = @book_2.reviews.create(user: "Lukas Bentley", rating: 5, title: "I enjoyed everything about this book",
        description: "The banter of the characters...")
      @review_05 = @book_2.reviews.create(user: "Natalia Morton", rating: 4, title: "Settle back and enjoy",
        description: "There are many references...")
      @review_06 = @book_2.reviews.create(user: "Lydia Mora", rating: 5, title: "Not Niven's best stuff",
        description: "This is a quick read...")

      @author_2 = Author.create(name: "Jerry Pournelle")
      @book_3 = Book.create(title: "Inferno", pages: 237, year_published: 1976, thumbnail: "https://upload.wikimedia.org/wikipedia/en/8/86/InfernoNovel.jpg")
      AuthorBook.create(author_id: @author_1.id, book_id: @book_3.id)
      AuthorBook.create(author_id: @author_2.id, book_id: @book_3.id)
      @review_07 = @book_3.reviews.create(user: "Lydia Mora", rating: 3, title: "A fun sci-fi take on Dante's Inferno",
        description: "Very entertaining SF/F revision...")
      @review_08 = @book_3.reviews.create(user: "Yahya Barrett", rating: 1, title: "Trash",
        description: "Niven and Pournelle rewrite Dante...")
      @review_09 = @book_3.reviews.create(user: "Savannah Steele", rating: 1, title: "A letdown",
        description: "Maybe it's just me, as...")

      @author_3 = Author.create(name: "J.R.R. Tolkein")
      @book_4 = Book.create(title: "The Fellowship of the Ring", pages: 423, year_published: 1954, thumbnail: "https://upload.wikimedia.org/wikipedia/en/8/8e/The_Fellowship_of_the_Ring_cover.gif")
      AuthorBook.create(author_id: @author_3.id, book_id: @book_4.id)
      @review_10 = @book_4.reviews.create(user: "Vincent Mcconnell", rating: 5, title: "A masterpiece",
        description: "I read this because...")
      @review_11 = @book_4.reviews.create(user: "Veronica Morgan", rating: 5, title: "Loved it!",
        description: "I finished this book...")
      @review_12 = @book_4.reviews.create(user: "Josie Orozco", rating: 5, title: "Can't believe I took so long to start reading these",
        description: "This is my first time...")
      @review_13 = @book_4.reviews.create(user: "Zainab Harrison", rating: 5, title: "Still fantastic!",
        description: "This is at least the...")

      @book_5 = Book.create(title: "The Two Towers", pages: 352, year_published: 1954, thumbnail: "https://upload.wikimedia.org/wikipedia/en/a/a1/The_Two_Towers_cover.gif")
      AuthorBook.create(author_id: @author_3.id, book_id: @book_5.id)
      @review_14 = @book_5.reviews.create(user: "Ellie-Mae Guerra", rating: 5, title: "Better each time I read it",
        description: "As this is my third reread...")
      @review_15 = @book_5.reviews.create(user: "Elsie Rich", rating: 4, title: "Truly epic",
        description: "4.5/5 stars. Once again...")
      @review_16 = @book_5.reviews.create(user: "Serena Pierce", rating: 5, title: "Better than Fellowship",
        description: "Amazing! I enjoyed this...")

      @book_6 = Book.create(title: "The Return of the King", pages: 416, year_published: 1955, thumbnail: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif")
      AuthorBook.create(author_id: @author_3.id, book_id: @book_6.id)
      @review_17 = @book_6.reviews.create(user: "Milly Dunlap", rating: 5, title: "Better than the movies",
        description: "The conclusion to my...")
      @review_18 = @book_6.reviews.create(user: "Lee John", rating: 5, title: "Tolkein is a master",
        description: "I love going back and...")
      @review_19 = @book_6.reviews.create(user: "Lukas Bentley", rating: 5, title: "Perfect",
        description: "A perfect final volume...")
      @review_20 = @book_6.reviews.create(user: "Lydia Mora", rating: 4, title: "Lovely",
        description: "The Return of the King...")
      @review_21 = @book_6.reviews.create(user: "Jax Lewis", rating: 4, title: "Better than the movie, but both are awesome",
        description: "Even if you love the...")

      top_authors = Author.top_rated
      expect(top_authors.first).to eq(@author_3)
      expect(top_authors.last).to eq(@author_2)
    end
  end
end
