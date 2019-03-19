require 'rails_helper'

RSpec.describe "user index", type: :feature do
  it "user can see all books" do
    author_1 = Author.create(name: "Larry Niven")
    book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    book_2 = Book.create(title: "The Goliath Stone", pages: 320, year_published: 2013, thumbnail: "https://images-na.ssl-images-amazon.com/images/I/51l%2BUTphB1L.jpg")
    ab_1 = AuthorBook.create(author_id: author_1.id, book_id: book_1.id)
    ab_2 = AuthorBook.create(author_id: author_1.id, book_id: book_2.id)

    visit '/books'

    expect(page).to have_content(author_1.name)
  end

end
