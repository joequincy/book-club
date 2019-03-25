class Book < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :pages, presence: true, numericality: { greater_than: 0 }
  validates :year_published, presence: true, numericality: { greater_than: 0 }

  def self.by_average_ratings(**args)
    query = self.select('books.*, AVG(reviews.rating) AS avg_rating')
                .left_joins(:reviews)
                .group('books.id')
                .order('avg_rating ' + (args[:dir] ||= 'DESC') + ' NULLS LAST')
    return query if args[:limit] === false
    query.limit(args[:limit] ||= 3)
  end

  def self.best_3
    by_average_ratings(dir: 'DESC', limit: 3)
  end

  def self.worst_3
    by_average_ratings(dir: 'ASC', limit: 3)
  end

  def self.by_pages(*nils, **args)
    self.order('pages ' + (args[:dir] ||= 'DESC'))
  end

  def self.by_reviews(*nils, **args)
    self.left_joins(:reviews)
        .group(:id)
        .order('COUNT(reviews.id) ' + (args[:dir] ||= 'DESC'))
  end

  def average_rating
    self.reviews.average(:rating) || 0
  end

  def top_reviews(limit = false)
    query = reviews.order(rating: :desc, created_at: :asc)
    return query if limit === false
    query.limit(limit)
  end

  def bottom_reviews(limit = false)
    query = reviews.order(rating: :asc, created_at: :desc)
    return query if limit === false
    query.limit(limit)
  end
end
