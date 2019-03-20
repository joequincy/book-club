class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews
  validates :title, presence: true
  validates :pages, presence: true, numericality: { greater_than: 0 }
  validates :year_published, presence: true, numericality: { greater_than: 0 }

  def self.by_average_ratings(**args)
    query = self.select('books.*, AVG(reviews.rating) AS avg_rating')
        .joins(:reviews)
        .group('books.id')
        .order('avg_rating ' + (args[:direction] ||= 'ASC'))
    return query if args[:limit] === false
    query.limit(args[:limit] ||= 3)
  end

  def self.best_3
    by_average_ratings(direction: 'DESC', limit: 3)
  end

  def self.worst_3
    by_average_ratings(direction: 'ASC', limit: 3)
  end

  def average_rating
    self.reviews.average(:rating)
  end
end
