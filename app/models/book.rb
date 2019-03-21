class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews
  validates :title, presence: true
  validates :pages, presence: true, numericality: { greater_than: 0 }
  validates :year_published, presence: true, numericality: { greater_than: 0 }

  def self.already_exists?(book)
    book.title = book.title.titleize
    self.exists?(title: book.title)
  end

  def average_rating
    self.reviews.average(:rating)
  end

end
