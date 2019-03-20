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

end
