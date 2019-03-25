require 'rails_helper'

RSpec.describe 'book: show page', type: :feature do
  before(:each) do
    @author_1 = Author.create(name: "Larry Niven")
    @book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    @ab_1 = AuthorBook.create(author_id: @author_1.id, book_id: @book_1.id)
    @review_1 = @book_1.reviews.create(user: "Veronica Morgan", rating: 4, title: "A tale of intrigue... but not in the way it sounds",
      description: "The entire time I was reading...")
    @review_2 = @book_1.reviews.create(user: "Chris Cobb", rating: 4, title: "Fabulous!",
      description: "Being an engineer by nature...")
    @review_3 = @book_1.reviews.create(user: "Hattie Le", rating: 5, title: "Outstanding book!",
      description: "The plot makes sense...")
  end

  it 'displays single book page' do
    visit book_path(@book_1)

    expect(page).to have_content(@book_1.title)
    expect(page).to have_content("Pages: #{@book_1.pages}")
    expect(page).to have_content("Year Published: #{@book_1.year_published}")
    expect(page).to have_css("img[src*='#{@book_1.thumbnail}']")
    expect(page).to have_content(@book_1.authors.first.name)
  end

  it 'displays all reviews for this book' do
    visit book_path(@book_1)

    expect(page).to have_content(@review_1.title)
    expect(page).to have_content("Rating: #{@review_1.rating}")
    expect(page).to have_content(@review_1.user)
    expect(page).to have_content(@review_1.description)

    expect(page).to have_content(@review_2.title)
    expect(page).to have_content("Rating: #{@review_2.rating}")
    expect(page).to have_content(@review_2.user)
    expect(page).to have_content(@review_2.description)

    expect(page).to have_content(@review_3.title)
    expect(page).to have_content("Rating: #{@review_3.rating}")
    expect(page).to have_content(@review_3.user)
    expect(page).to have_content(@review_3.description)
  end

  describe 'when a user visits a book page to add a review' do
    it 'can add a new review for a book' do
      visit book_path(@book_1)

      click_on("+ Add a New Review")
      expect(current_path).to eq(new_book_review_path(@book_1))

      fill_in "review[title]", with: "This Book Was Great!"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "Review Description"
      fill_in "review[user]", with: "User Name"
      click_on "Create Review"

      expect(current_path).to eq(book_path(@book_1))

      review = Review.last

      within "#review-#{review.id}" do
        expect(page).to have_content(review.title)
        expect(page).to have_content("Rating: #{review.rating}")
        expect(page).to have_content(review.description)
        expect(page).to have_content(review.user)
      end
    end

    it 'will post all user names in title case' do
      visit book_path(@book_1)

      click_on("+ Add a New Review")
      expect(current_path).to eq(new_book_review_path(@book_1))

      fill_in "review[title]", with: "This Book Was Great!"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "Review Description"
      fill_in "review[user]", with: "abby robinson"
      click_on "Create Review"

      review = Review.last

      within "#review-#{review.id}" do
        expect(page).to have_content("Abby Robinson")
      end
    end

    it "will not allow a user to review a book twice" do

      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: "This Book Was Great!"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "Review Description"
      fill_in "review[user]", with: "Abby Robinson"
      click_on "Create Review"

      visit new_book_review_path(@book_1)

      fill_in "review[title]", with: "Not as good the second time"
      fill_in "review[rating]", with: 2
      fill_in "review[description]", with: "Review Description"
      fill_in "review[user]", with: "Abby Robinson"
      click_on "Create Review"

      expect(page).to_not have_content("Not as good the second time")
    end

    it "has a link to delete a book" do
      visit book_path(@book_1)

      click_link("- Delete This Book")

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(@book_1.title)
    end

    describe 'for each author' do
      it 'displays the author name as a link' do
        visit book_path(@book_1)

        click_link(@author_1.name)
        expect(page).to have_current_path(author_path(@author_1))
      end
    end

    describe 'for each user' do
      it 'displays the username as a link' do
        visit book_path(@book_1)
        within '#top-reviews' do
          click_link(@review_1.user)
          expect(page).to have_current_path(user_path(@review_1.user))
        end

        visit book_path(@book_1)
        within '#bottom-reviews' do
          click_link(@review_1.user)
          expect(page).to have_current_path(user_path(@review_1.user))
        end

        visit book_path(@book_1)
        within '#all-reviews' do
          click_link(@review_1.user)
          expect(page).to have_current_path(user_path(@review_1.user))
        end

        visit book_path(@book_1)
        within '#top-reviews' do
          click_link(@review_2.user)
          expect(page).to have_current_path(user_path(@review_2.user))
        end

        visit book_path(@book_1)
        within '#bottom-reviews' do
          click_link(@review_2.user)
          expect(page).to have_current_path(user_path(@review_2.user))
        end

        visit book_path(@book_1)
        within '#all-reviews' do
          click_link(@review_2.user)
          expect(page).to have_current_path(user_path(@review_2.user))
        end

        visit book_path(@book_1)
        within '#top-reviews' do
          click_link(@review_3.user)
          expect(page).to have_current_path(user_path(@review_3.user))
        end

        visit book_path(@book_1)
        within '#bottom-reviews' do
          click_link(@review_3.user)
          expect(page).to have_current_path(user_path(@review_3.user))
        end

        visit book_path(@book_1)
        within '#all-reviews' do
          click_link(@review_3.user)
          expect(page).to have_current_path(user_path(@review_3.user))
        end
      end
    end
  end
end
