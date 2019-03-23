require 'rails_helper'

RSpec.describe 'general: navigation', type: :feature do
  describe 'when a user visits a webpage' do
    describe 'they can see a navigation bar'
      it 'links to home' do
        visit books_path

        within 'nav.main' do
          click_on("Home")
          expect(current_path).to eq('/')
        end
      end

      it 'links to browse all books' do
        book = Book.create(title: "Title", pages: 123, year_published: 1793)
        visit books_path

        within 'nav.main' do
          click_on("Browse All Books")
          expect(current_path).to eq(books_path)
        end
      end
  end
end
