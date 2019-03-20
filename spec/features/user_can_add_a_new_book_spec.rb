require 'rails_helper'

RSpec.describe "as a user", type: :feature do
  describe "when I visits books/new" do
    it "can add a new book through a form" do

      visit new_book_path

      fill_in "book[title]", with: "1984"
      fill_in "book[authors]", with: "George Orwell"
      fill_in "book[pages]", with: 328
      fill_in "book[year_published]", with: 1949
      fill_in "book[thumbnail]", with: "http://t0.gstatic.com/images?q=tbn:ANd9GcR6NkynD6-nnDXL8_mXavQqRtkksgI_9iJPRjL01m6oesT8rjx6"
      click_on "Create Book"

      expect(page).to have_content("1984")
      expect(page).to have_content("George Orwell")
      expect(page).to have_content(328)
      expect(page).to have_css("img[src*='http://t0.gstatic.com/images?q=tbn:ANd9GcR6NkynD6-nnDXL8_mXavQqRtkksgI_9iJPRjL01m6oesT8rjx6']")

    end
  end
end
