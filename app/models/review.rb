class Review < ApplicationRecord
  belongs_to :book
  validates :title, presence: true
  validates :description, presence: true
  validates :user, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6 }

  def self.top_reviewers
    reviewers = self.group('reviews.user')
                    .count
    reviewers.sort_by{|k,v|-v}.first(3)
  end

  def self.already_exists?(review, book)
    review.user = review.user.titleize
    book.reviews.exists?(user: review.user)
  end

  def self.user_by_date(user: nil, dir:)
    where(user: user)
   .order('created_at ' + dir)
  end
end
