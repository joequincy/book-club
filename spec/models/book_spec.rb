require 'rails_helper'

RSpec.describe Book, type: :model do

  describe 'relationships' do
    it { should have_many(:author_books) }
    it { should have_many(:authors).through(:author_books) }
    it { should have_many(:reviews) }
  end

  describe 'validations' do
    describe 'Required Field(s)' do
      it 'should be invalid if missing a title' do
        book = Book.create(pages: 48, year_published: 1953, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end

      it 'should be invalid if missing page numbers' do
        book = Book.create(title:"Title", year_published: 1953, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end

      it 'should be invalid if page numbers is not a number' do
        book = Book.create(title: "Title", pages: "forty-eight", year_published: 1953, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end

      it 'should be invalid if page numbers is less than 1' do
        book = Book.create(title: "Title", pages: 0, year_published: 1953, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid

        book = Book.create(title: "Title", pages: -29, year_published: 1953, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end


      it 'should be invalid if missing publication year' do
        book = Book.create(title: "Title", pages: 100, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end

      it 'should be invalid if publication year is not a number' do
        book = Book.create(title: "Title", pages: 100, year_published: "nineteen eighty six", thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end

      it 'should be invalid if publication year is less than 1' do
        book = Book.create(title: "Title", pages: 100, year_published: 0, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid

        book = Book.create(title: "Title", pages: 100, year_published: -1923, thumbnail: 'http://image.jpg')
        expect(book).to_not be_valid
      end
    end
  end

  describe 'content validations' do
    describe 'when you create a new book' do
      it 'should convert the title to title caps' do
        book = Book.create(title: "return of the king", pages: 100, year_published: 10, thumbnail: 'http://image.jpg')
        Book.already_exists?(book)

        expect(book.title).to eq("Return Of The King")
      end
    end

    describe 'when you try to create a book that already exists' do
      it 'will validate that the book already exists' do
        book_1 = Book.new(title: "Return Of The King", pages: 100, year_published: 10, thumbnail: 'http://image.jpg')
        actual = Book.already_exists?(book_1)

        expect(actual).to eq(false)

        book_1.save
        book_2 = Book.new(title: "Return Of The King", pages: 100, year_published: 10, thumbnail: 'http://image.jpg')
        actual = Book.already_exists?(book_2)

        expect(actual).to eq(true)
      end
    end
  end
end
