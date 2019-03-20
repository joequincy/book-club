require 'rails_helper'

RSpec.describe "user index", type: :feature do
  it "user can see all books" do
    author_1 = Author.create(name: "Larry Niven")
    book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    book_2 = Book.create(title: "The Goliath Stone", pages: 320, year_published: 2013, thumbnail: "https://images-na.ssl-images-amazon.com/images/I/51l%2BUTphB1L.jpg")
    ab_1 = AuthorBook.create(author_id: author_1.id, book_id: book_1.id)
    ab_2 = AuthorBook.create(author_id: author_1.id, book_id: book_2.id)

    visit books_path

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year Published: #{book_1.year_published}")
    expect(page).to have_css("img[src*='#{book_1.thumbnail}']")

    expect(page).to have_content(book_2.title)
    expect(page).to have_content("Pages: #{book_2.pages}")
    expect(page).to have_content("Year Published: #{book_2.year_published}")
    expect(page).to have_css("img[src*='#{book_2.thumbnail}']")
  end

end
