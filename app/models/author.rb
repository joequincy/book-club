class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
  has_many :reviews, through: :author_books
  validates :name, presence: true

  def self.top_rated
    select('authors.*, AVG(reviews.rating) AS avg_rating')
   .joins(:reviews)
   .group('authors.id')
   .order('avg_rating DESC')
   .limit(3)
  end
end
