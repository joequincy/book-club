# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
authors = {}
books = {}

options = {headers: true, header_converters: :symbol}

CSV.foreach('./db/authors.csv', options) do |row|
  author = row.to_h
  authors[author[:name]] = Author.create(author)
end

CSV.foreach('./db/books.csv', options) do |row|
  book = row.to_h.except(:authors, :reviews)
  books[book[:title]] = Book.create(book)
  row[:authors].split(',').each do |author|
    AuthorBook.create(book_id: books[book[:title]].id,
                    author_id: authors[author].id)
  end
end

CSV.foreach('./db/reviews.csv', options) do |row|
  review = row.to_h.except(:book)
  review[:book] = books[row[:book]]
  Review.create(review)
end
