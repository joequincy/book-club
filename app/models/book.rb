class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def average_rating
    self.reviews.average(:rating)
  end

end
