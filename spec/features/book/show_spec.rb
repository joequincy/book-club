require 'rails_helper'

RSpec.describe 'book: show page', type: :feature do
  it 'displays single book page' do
    author_1 = Author.create(name: "Larry Niven")
    book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    ab_1 = AuthorBook.create(author_id: author_1.id, book_id: book_1.id)

    visit book_path(book_1)

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Year Published: #{book_1.year_published}")
    expect(page).to have_css("img[src*='#{book_1.thumbnail}']")
    expect(page).to have_content(book_1.authors.first.name)
  end

  it 'displays all reviews for this book' do
    author_1 = Author.create(name: "Larry Niven")
    book_1 = Book.create(title: "Ringworld", pages: 430, year_published: 1970, thumbnail: "https://d2svrcwl6l7hz1.cloudfront.net/content/B00CNTUVLO/resources/0?mime=image/*")
    ab_1 = AuthorBook.create(author_id: author_1.id, book_id: book_1.id)
    review_1 = book_1.reviews.create(user: "Veronica Morgan", rating: 4, title: "A tale of intrigue... but not in the way it sounds",
      description: "The entire time I was reading this book I kept thinking to myself \"what an intriguing concept\". It's just interesting and so very different from most sci-fi books I've read before. The author really handles alien concepts in an alien way. At times you'll relate or understand but more often you just go \"huh... interesting\". I really enjoyed it but it took me a little while to truly get engrossed in it, probably because of how unique and alien the ideas in it are. I highly recommend it just for the experience of it.")
    review_2 = book_1.reviews.create(user: "Chris Cobb", rating: 4, title: "Fabulous!",
      description: "Being an engineer by nature, and by training (10 yrs at MIT), when I read this book (in the 1970s) I went supernova. Massive engineering on an unimaginable scale, made real by Niven.")
    review_3 = book_1.reviews.create(user: "Hattie Le", rating: 5, title: "Outstanding book!",
      description: "The plot makes sense and the twist in the end is interesting. Niven isn't the best writer out there, but his ideas are outstanding. Hard sci-fi is hard to come by and this one is a classic. Well worth a read. (Now, unfortunately, I cannot say that for the two following novels in the Ringworld saga, but the \"... Of Worlds\" series kinda makes up for it.) I've dreamt of what it would be like to live on the Ringworld; Engineers comes as close as I can think.")

    visit book_path(book_1)

    within '#all-reviews' do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content(review_1.user)
      expect(page).to have_content(review_1.description)

      expect(page).to have_content(review_2.title)
      expect(page).to have_content("Rating: #{review_2.rating}")
      expect(page).to have_content(review_2.user)
      expect(page).to have_content(review_2.description)

      expect(page).to have_content(review_3.title)
      expect(page).to have_content("Rating: #{review_3.rating}")
      expect(page).to have_content(review_3.user)
      expect(page).to have_content(review_3.description)
    end
  end
end
