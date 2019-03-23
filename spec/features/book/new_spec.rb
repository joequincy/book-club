require 'rails_helper'

RSpec.describe 'book: new page', type: :feature do
  describe "when I visits books/new" do
    it "can add a new book through a form" do

      visit new_book_path

      fill_in "book[title]", with: "1984"
      fill_in "authors", with: "George Orwell"
      fill_in "book[pages]", with: 328
      fill_in "book[year_published]", with: 1949
      fill_in "book[thumbnail]", with: "http://t0.gstatic.com/images?q=tbn:ANd9GcR6NkynD6-nnDXL8_mXavQqRtkksgI_9iJPRjL01m6oesT8rjx6"
      click_on "Create Book"

      expect(page).to have_content("1984")
      expect(page).to have_content("George Orwell")
      expect(page).to have_content('Pages: 328')
      expect(page).to have_content('Year Published: 1949')
      expect(page).to have_css("img[src*='http://t0.gstatic.com/images?q=tbn:ANd9GcR6NkynD6-nnDXL8_mXavQqRtkksgI_9iJPRjL01m6oesT8rjx6']")
    end

    it "will title caps the book title" do

      visit new_book_path

      fill_in "book[title]", with: "the return of the king"
      fill_in "authors", with: "J.R.R. Tolkein"
      fill_in "book[pages]", with: 416
      fill_in "book[year_published]", with: 1955
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif"
      click_on "Create Book"

      expect(page).to have_content("The Return Of The King")
      expect(page).to have_content("J.R.R. Tolkein")
      expect(page).to have_content('Pages: 416')
      expect(page).to have_content('Year Published: 1955')
      expect(page).to have_css("img[src*='https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif']")
    end

    it "will not add a book that already exists" do

      visit new_book_path

      fill_in "book[title]", with: "The Return Of The King"
      fill_in "authors", with: "J.R.R. Tolkein"
      fill_in "book[pages]", with: 416
      fill_in "book[year_published]", with: 1955
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif"
      click_on "Create Book"

      visit new_book_path

      fill_in "book[title]", with: "The Return Of The King"
      fill_in "authors", with: "J.R.R. Tolkein"
      fill_in "book[pages]", with: 416
      fill_in "book[year_published]", with: 1955
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif"
      click_on "Create Book"

      expect(current_path).to eq(new_book_path)
    end

    it "will not add an author that already exists" do

      visit new_book_path

      fill_in "book[title]", with: "The Return Of The King"
      fill_in "authors", with: "J.R.R. Tolkein"
      fill_in "book[pages]", with: 416
      fill_in "book[year_published]", with: 1955
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif"
      click_on "Create Book"
      author_1 = Book.last.authors.first

      visit new_book_path

      fill_in "book[title]", with: "The Fellowship Of The Ring"
      fill_in "authors", with: "J.R.R. Tolkein"
      fill_in "book[pages]", with: 416
      fill_in "book[year_published]", with: 1955
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/1/11/The_Return_of_the_King_cover.gif"
      click_on "Create Book"

      author_2 = Book.last.authors.first
      expect(author_1.id).to eq(author_2.id)
    end

    it "will add books with multiple authors" do

      visit new_book_path

      fill_in "book[title]", with: "Inferno"
      fill_in "authors", with: "Larry Niven, Jerry Pournelle"
      fill_in "book[pages]", with: 237
      fill_in "book[year_published]", with: 1976
      fill_in "book[thumbnail]", with: "https://upload.wikimedia.org/wikipedia/en/8/86/InfernoNovel.jpg"
      click_on "Create Book"

      author_1 = Book.last.authors.first
      author_2 = Book.last.authors.last
      expect(author_1.id).to_not eq(author_2.id)
      expect(page).to have_content("Larry Niven")
      expect(page).to have_content("Jerry Pournelle")
    end
  end
end
