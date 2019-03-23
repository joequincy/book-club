require 'rails_helper'

RSpec.describe Review, type: :model do

  describe 'relationships' do
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it 'should be invalid if missing a title' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(rating: 5, description: "Description", user: "Username")
      expect(review).to_not be_valid
    end

    it 'should be invalid if missing a description' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(title: "Title", rating: 5, user: "Username")
      expect(review).to_not be_valid
    end

    it 'should be invalid if missing a user' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(title: "Title", description: "Description", rating: 5)
      expect(review).to_not be_valid
    end

    it 'should be invalid if missing a rating' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(title: "Title", description: "Description", user: "Username")
      expect(review).to_not be_valid
    end

    it 'should be invalid if rating is not a number' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(title: "Title", rating: "Five", description: "Description", user: "Username")
      expect(review).to_not be_valid
    end

    it 'should be invalid if rating is not between 1 and 5' do
      book = Book.create(title:"Title", pages: 100, year_published: 1953, thumbnail: 'http://image.jpg')
      review = book.reviews.create(title: "Title", rating: 10, description: "Description", user: "Username")
      expect(review).to_not be_valid

      review = book.reviews.create(title: "Title", rating: 0, description: "Description", user: "Username")
      expect(review).to_not be_valid

      review = book.reviews.create(title: "Title", rating: -1, description: "Description", user: "Username")
      expect(review).to_not be_valid
    end
  end

  describe 'queries' do
    it 'should get top reviewers and their review counts' do
      @author_1 = Author.create(name: "Larry Niven")
      @book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
      AuthorBook.create(author_id: @author_1.id, book_id: @book_1.id)
      @review_01 = @book_1.reviews.create(user: "Veronica Morgan", rating: 4, title: "A tale of intrigue... but not in the way it sounds",
        description: "The entire time...")
      @review_02 = @book_1.reviews.create(user: "Chris Cobb", rating: 4, title: "Fabulous!",
        description: "Being an engineer by nature...")
      @review_03 = @book_1.reviews.create(user: "Hattie Le", rating: 5, title: "Outstanding book!",
        description: "The plot makes sense...")
      @review_04 = @book_1.reviews.create(user: "Lukas Bentley", rating: 5, title: "I enjoyed everything about this book",
        description: "The banter of the characters...")
      @review_05 = @book_1.reviews.create(user: "Natalia Morton", rating: 4, title: "Settle back and enjoy",
        description: "There are many references...")
      @review_06 = @book_1.reviews.create(user: "Lydia Mora", rating: 5, title: "Not Niven's best stuff",
        description: "This is a quick read...")
      @review_07 = @book_1.reviews.create(user: "Lydia Mora", rating: 3, title: "A fun sci-fi take on Dante's Inferno",
        description: "Very entertaining SF/F revision...")
      @review_08 = @book_1.reviews.create(user: "Yahya Barrett", rating: 1, title: "Trash",
        description: "Niven and Pournelle rewrite Dante...")
      @review_09 = @book_1.reviews.create(user: "Savannah Steele", rating: 1, title: "A letdown",
        description: "Maybe it's just me, as...")
      @review_10 = @book_1.reviews.create(user: "Vincent Mcconnell", rating: 5, title: "A masterpiece",
        description: "I read this because...")
      @review_11 = @book_1.reviews.create(user: "Veronica Morgan", rating: 5, title: "Loved it!",
        description: "I finished this book...")
      @review_12 = @book_1.reviews.create(user: "Josie Orozco", rating: 5, title: "Can't believe I took so long to start reading these",
        description: "This is my first time...")
      @review_13 = @book_1.reviews.create(user: "Zainab Harrison", rating: 5, title: "Still fantastic!",
        description: "This is at least the...")
      @review_14 = @book_1.reviews.create(user: "Ellie-Mae Guerra", rating: 5, title: "Better each time I read it",
        description: "As this is my third reread...")
      @review_15 = @book_1.reviews.create(user: "Elsie Rich", rating: 4, title: "Truly epic",
        description: "4.5/5 stars. Once again...")
      @review_16 = @book_1.reviews.create(user: "Serena Pierce", rating: 5, title: "Better than Fellowship",
        description: "Amazing! I enjoyed this...")
      @review_17 = @book_1.reviews.create(user: "Milly Dunlap", rating: 5, title: "Better than the movies",
        description: "The conclusion to my...")
      @review_18 = @book_1.reviews.create(user: "Lee John", rating: 5, title: "Tolkein is a master",
        description: "I love going back and...")
      @review_19 = @book_1.reviews.create(user: "Lukas Bentley", rating: 5, title: "Perfect",
        description: "A perfect final volume...")
      @review_20 = @book_1.reviews.create(user: "Lydia Mora", rating: 4, title: "Lovely",
        description: "The Return of the King...")
      @review_21 = @book_1.reviews.create(user: "Jax Lewis", rating: 4, title: "Better than the movie, but both are awesome",
        description: "Even if you love the...")

      top_reviewers = Review.top_reviewers
      expect(top_reviewers.first).to eq(["Lydia Mora", 3])
      expect(top_reviewers).to include(["Lukas Bentley", 2])
      expect(top_reviewers).to include(["Veronica Morgan", 2])
    end
  end

  describe 'content validations' do
    describe 'when you create a new review' do
      it 'should convert the username to title caps' do
        review = Review.create(user: "abby robinson", title: "Great Book", rating: 5, description: "Description")
        book = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
        Review.already_exists?(review, book)

        expect(review.user).to eq("Abby Robinson")
      end
    end

    describe 'when you try to review a book you have already reviewed' do
      it 'will validate that the user already exists in that books reviews' do
        book = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
        review_1 = Review.create(user: "Abby Robinson", title: "Great Book", rating: 5, description: "Description")

        actual = Review.already_exists?(review_1, book)

        expect(actual).to eq(false)

        review_1.save
        book.reviews << review_1
        
        review_2 = Review.create(user: "Abby Robinson", title: "Great Book", rating: 5, description: "Description")
        actual = Review.already_exists?(review_2, book)

        expect(actual).to eq(true)
      end
    end
  end
end
